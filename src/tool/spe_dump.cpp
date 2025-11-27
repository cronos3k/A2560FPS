// Minimal SPEC extractor: dumps images in a SPEC file to PCX
// Usage: spe-dump <spec_file> [out_dir]

#if defined HAVE_CONFIG_H
#   include "config.h"
#endif

#include <cstdio>
#include <cstring>
#include <string>

#include "common.h"
#include "imlib/specs.h"
#include "imlib/image.h"
#include "imlib/pcxread.h"

#ifdef _WIN32
#  include <direct.h>
#else
#  include <sys/stat.h>
#  include <sys/types.h>
#endif

static void ensure_dir(const char *path)
{
#ifdef _WIN32
    _mkdir(path);
#else
    mkdir(path, 0755);
#endif
}

static std::string base_name(const std::string &p)
{
    size_t s = p.find_last_of("/\\");
    if (s == std::string::npos) return p;
    return p.substr(s + 1);
}

int main(int argc, char **argv)
{
    if (argc < 2)
    {
        printf("Usage: %s <spec_file> [out_dir]\n", argv[0]);
        return 1;
    }

    const char *spec_file = argv[1];
    std::string out_dir = argc >= 3 ? argv[2] : "art-extracted";
    ensure_dir(out_dir.c_str());

    jFILE fp(spec_file, "rb");
    if (fp.open_failure())
    {
        printf("ERROR: cannot open %s\n", spec_file);
        return 2;
    }

    spec_directory dir(&fp);

    // Find first palette if any
    int palid = -1;
    for (int i = 0; i < dir.total; ++i)
        if (dir.entries[i]->type == SPEC_PALETTE) { palid = i; break; }
    palette *pal = palid == -1 ? new palette(256) : new palette(dir.entries[palid], &fp);

    int dumped = 0;
    for (int i = 0; i < dir.total; ++i)
    {
        uint8_t t = dir.entries[i]->type;
        if (t == SPEC_IMAGE || t == SPEC_FORETILE || t == SPEC_BACKTILE ||
            t == SPEC_CHARACTER || t == SPEC_CHARACTER2)
        {
            image *im = new image(&fp, dir.entries[i]);
            std::string name = dir.entries[i]->name ? dir.entries[i]->name : std::to_string(i);
            std::string bn = base_name(spec_file);
            std::string out = out_dir + "/" + bn + "_" + name;
            if (out.size() < 4 || out.substr(out.size()-4) != ".pcx") out += ".pcx";
            write_PCX(im, pal, out.c_str());
            delete im;
            ++dumped;
        }
    }

    delete pal;
    printf("Dumped %d images from %s into %s\n", dumped, spec_file, out_dir.c_str());
    return 0;
}

