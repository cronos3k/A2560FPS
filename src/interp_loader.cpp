/*
 *  Abuse - dark 2D side-scrolling platform game
 *  Copyright (c) 2025 AI-Enhanced Development
 *
 *  This software was released into the Public Domain. As with most public
 *  domain software, no warranty is made or implied.
 */

#if defined HAVE_CONFIG_H
#   include "config.h"
#endif

#include "common.h"

#include "interp_loader.h"
#include "sdlport/setup.h"
#include "game.h"
#include "level.h"
#include "palette.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fstream>
#include <sstream>

// Use stb_image for PNG loading (single-header library)
#define STB_IMAGE_IMPLEMENTATION
#define STBI_ONLY_PNG
#include "stb_image.h"

// JSON parsing - simple manual parsing for our specific format
// (avoids external dependency like nlohmann/json)

extern Settings settings;
extern level *current_level;

// Global instance
InterpSpriteManager *interp_sprite_manager = NULL;

// Timing globals for sub-frame calculation
static int last_physics_tick = 0;
static float current_render_offset = 0.0f;

//=============================================================================
// Utility: Simple JSON parser for our metadata files
//=============================================================================

static bool parse_json_int(const std::string &json, const char *key, int &value)
{
    std::string search = std::string("\"") + key + "\":";
    size_t pos = json.find(search);
    if (pos == std::string::npos)
        return false;

    pos += search.length();
    // Skip whitespace
    while (pos < json.length() && (json[pos] == ' ' || json[pos] == '\t'))
        pos++;

    // Parse number
    size_t end = pos;
    while (end < json.length() && (isdigit(json[end]) || json[end] == '-'))
        end++;

    if (end > pos)
    {
        value = atoi(json.substr(pos, end - pos).c_str());
        return true;
    }
    return false;
}

static bool parse_json_string(const std::string &json, const char *key, std::string &value)
{
    std::string search = std::string("\"") + key + "\":";
    size_t pos = json.find(search);
    if (pos == std::string::npos)
        return false;

    pos += search.length();
    // Skip whitespace and opening quote
    while (pos < json.length() && (json[pos] == ' ' || json[pos] == '\t'))
        pos++;
    if (pos >= json.length() || json[pos] != '"')
        return false;
    pos++; // skip opening "

    // Find closing quote
    size_t end = pos;
    while (end < json.length() && json[end] != '"')
        end++;

    if (end > pos)
    {
        value = json.substr(pos, end - pos);
        return true;
    }
    return false;
}

//=============================================================================
// InterpCollectionMetadata implementation
//=============================================================================

bool InterpCollectionMetadata::load_from_json(const char *json_path)
{
    // Load JSON file
    std::ifstream file(json_path);
    if (!file.is_open())
    {
        fprintf(stderr, "Failed to open metadata: %s\n", json_path);
        return false;
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    std::string json = buffer.str();
    file.close();

    // Parse target dimensions
    if (!parse_json_int(json, "target_width", target_width) ||
        !parse_json_int(json, "target_height", target_height))
    {
        fprintf(stderr, "Failed to parse target dimensions from %s\n", json_path);
        return false;
    }

    // Parse frames array
    size_t frames_pos = json.find("\"frames\":");
    if (frames_pos == std::string::npos)
    {
        fprintf(stderr, "No frames array in %s\n", json_path);
        return false;
    }

    // Find opening bracket of array
    size_t array_start = json.find('[', frames_pos);
    size_t array_end = json.find(']', array_start);
    if (array_start == std::string::npos || array_end == std::string::npos)
    {
        fprintf(stderr, "Malformed frames array in %s\n", json_path);
        return false;
    }

    // Parse each frame object
    size_t pos = array_start + 1;
    while (pos < array_end)
    {
        // Find next object
        size_t obj_start = json.find('{', pos);
        if (obj_start >= array_end)
            break;

        size_t obj_end = json.find('}', obj_start);
        if (obj_end >= array_end)
            break;

        std::string obj = json.substr(obj_start, obj_end - obj_start + 1);

        InterpFrameMetadata frame;
        if (parse_json_string(obj, "filename", frame.filename) &&
            parse_json_int(obj, "original_width", frame.original_width) &&
            parse_json_int(obj, "original_height", frame.original_height) &&
            parse_json_int(obj, "pad_left", frame.pad_left) &&
            parse_json_int(obj, "pad_top", frame.pad_top) &&
            parse_json_int(obj, "normalized_width", frame.normalized_width) &&
            parse_json_int(obj, "normalized_height", frame.normalized_height))
        {
            frames.push_back(frame);
        }

        pos = obj_end + 1;
    }

    printf("Loaded metadata: %s (%d frames, target %dx%d)\n",
           json_path, (int)frames.size(), target_width, target_height);

    return frames.size() > 0;
}

//=============================================================================
// InterpCollection implementation
//=============================================================================

InterpCollection::InterpCollection(const char *collection_name)
{
    name = collection_name;
}

InterpCollection::~InterpCollection()
{
    // Clean up figures
    for (size_t i = 0; i < figures.size(); i++)
    {
        if (figures[i].fig)
        {
            delete figures[i].fig;
            figures[i].fig = NULL;
        }
    }
    figures.clear();
}

bool InterpCollection::load_png_to_image(const char *png_path, image **out_img, palette *pal)
{
    // Load PNG using stb_image
    int width, height, channels;
    unsigned char *data = stbi_load(png_path, &width, &height, &channels, 4); // Force RGBA
    if (!data)
    {
        fprintf(stderr, "Failed to load PNG: %s\n", png_path);
        return false;
    }

    // Create game image (8-bit indexed)
    image *img = new image(ivec2(width, height));

    // Convert RGBA to indexed palette
    // Simple nearest-color matching to game palette
    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            int idx = (y * width + x) * 4;
            unsigned char r = data[idx + 0];
            unsigned char g = data[idx + 1];
            unsigned char b = data[idx + 2];
            unsigned char a = data[idx + 3];

            uint8_t color;
            if (a < 128)
            {
                // Transparent pixel
                color = 0;
            }
            else
            {
                // Find nearest palette color
                int best_dist = 999999;
                color = 0;

                for (int i = 0; i < 256; i++)
                {
                    int pr = pal->red(i);
                    int pg = pal->green(i);
                    int pb = pal->blue(i);

                    int dr = r - pr;
                    int dg = g - pg;
                    int db = b - pb;
                    int dist = dr * dr + dg * dg + db * db;

                    if (dist < best_dist)
                    {
                        best_dist = dist;
                        color = i;
                    }
                }
            }

            img->PutPixel(ivec2(x, y), color);
        }
    }

    stbi_image_free(data);
    *out_img = img;
    return true;
}

figure *InterpCollection::create_figure_from_image(image *img, int frame_index)
{
    if (!img)
        return NULL;

    // Manually create and initialize figure struct
    // (Can't use constructor since it expects a file pointer)
    figure *fig = (figure*)malloc(sizeof(figure));
    if (!fig)
        return NULL;

    // Create TransImage for forward direction
    fig->forward = new TransImage(img, name.c_str());

    // Create flipped image for backward direction
    image *flipped = img->copy();
    flipped->FlipX();
    fig->backward = new TransImage(flipped, name.c_str());
    delete flipped;

    // Calculate x-center (registration point)
    // Use frame metadata if available
    if (frame_index >= 0 && frame_index < (int)metadata.frames.size())
    {
        InterpFrameMetadata &meta = metadata.frames[frame_index];
        fig->xcfg = meta.original_width / 2; // Center of sprite
    }
    else
    {
        fig->xcfg = img->Size().x / 2;
    }

    // Initialize other fields (not used for rendering)
    fig->hit_damage = 0;
    fig->advance = 0;
    fig->hit = NULL;
    fig->f_damage = NULL;
    fig->b_damage = NULL;

    return fig;
}

bool InterpCollection::load()
{
    printf("Loading interpolated sprites: %s\n", name.c_str());

    // Load metadata
    char metadata_path[512];
    snprintf(metadata_path, sizeof(metadata_path),
             "AIWork/frame-interpolation/metadata/%s_metadata.json", name.c_str());

    if (!metadata.load_from_json(metadata_path))
    {
        fprintf(stderr, "Failed to load metadata for %s\n", name.c_str());
        return false;
    }

    // Get game palette (use first palette found)
    palette *pal = the_game->current_palette();
    if (!pal)
    {
        fprintf(stderr, "No game palette available\n");
        return false;
    }

    // Load each PNG frame
    char frames_dir[512];
    snprintf(frames_dir, sizeof(frames_dir),
             "AIWork/frame-interpolation/final/%s", name.c_str());

    int loaded_count = 0;
    for (size_t i = 0; i < metadata.frames.size(); i++)
    {
        // Extract original frame number from filename (e.g., "0.png" -> 0, "142.png" -> 142)
        std::string filename = metadata.frames[i].filename;
        size_t dot_pos = filename.find('.');
        if (dot_pos == std::string::npos)
        {
            fprintf(stderr, "Invalid filename format: %s\n", filename.c_str());
            continue;
        }

        int original_frame_num = atoi(filename.substr(0, dot_pos).c_str());

        // Build the map: original frame number → base index in figures vector
        // Each original frame has 4 interpolated frames
        original_frame_map[original_frame_num] = loaded_count;

        // Load 4 interpolated frames for this original frame
        // Files are named like: 0000000.png, 0000001.png, 0000002.png, 0000003.png (for original frame 0)
        for (int interp_idx = 0; interp_idx < 4; interp_idx++)
        {
            char png_path[512];
            int file_index = loaded_count + interp_idx;
            snprintf(png_path, sizeof(png_path), "%s/%07d.png",
                     frames_dir, file_index);

            // Check if file exists
            struct stat st;
            if (stat(png_path, &st) != 0)
            {
                fprintf(stderr, "Frame not found: %s\n", png_path);
                continue;
            }

            // Load PNG
            image *img = NULL;
            if (!load_png_to_image(png_path, &img, pal))
            {
                fprintf(stderr, "Failed to load: %s\n", png_path);
                continue;
            }

            // Create figure
            figure *fig = create_figure_from_image(img, i);
            delete img; // TransImage made its own copy

            if (!fig)
            {
                fprintf(stderr, "Failed to create figure for: %s\n", png_path);
                continue;
            }

            InterpFigure ifig;
            ifig.fig = fig;
            ifig.original_frame = original_frame_num;
            ifig.sub_offset = interp_idx / 4.0f;

            figures.push_back(ifig);
        }

        loaded_count += 4; // We loaded 4 interpolated frames
    }

    printf("  Loaded %d/%d frames for %s\n", loaded_count, (int)metadata.frames.size(), name.c_str());
    return loaded_count > 0;
}

figure *InterpCollection::get_interpolated_frame(int physics_frame, float render_offset,
                                                 int total_physics_frames)
{
    if (figures.empty())
        return NULL;

    // physics_frame is the current frame number from the game's animation sequence
    // We need to look it up in our original_frame_map to find the corresponding interpolated frames

    // Find the base index for this original frame number
    std::map<int, int>::iterator it = original_frame_map.find(physics_frame);
    if (it == original_frame_map.end())
    {
        // Frame not found in map - this original frame wasn't interpolated
        // Fall back to first frame (caller will use original sprite instead)
        return NULL;
    }

    int base_index = it->second; // Base index of the 4 interpolated frames

    // Select which of the 4 interpolated frames to use based on render_offset
    // render_offset ranges from 0.0 to 1.0
    // 0.0-0.25 = frame 0, 0.25-0.5 = frame 1, 0.5-0.75 = frame 2, 0.75-1.0 = frame 3
    int sub_index = (int)(render_offset * 4.0f);
    if (sub_index < 0) sub_index = 0;
    if (sub_index > 3) sub_index = 3; // Clamp to 0-3

    int final_index = base_index + sub_index;

    // Safety check
    if (final_index < 0 || final_index >= (int)figures.size())
        return NULL;

    return figures[final_index].fig;
}

//=============================================================================
// InterpSpriteManager implementation
//=============================================================================

InterpSpriteManager::InterpSpriteManager()
{
    enabled = false;
    game_palette = NULL;
}

InterpSpriteManager::~InterpSpriteManager()
{
    shutdown();
}

bool InterpSpriteManager::initialize()
{
    if (!settings.interpolated_sprites_enabled)
    {
        printf("Interpolated sprites disabled in settings\n");
        return false;
    }

    printf("\n=== Initializing Interpolated Sprites ===\n");

    enabled = true;

    // Load all collections
    const char *collection_names[] = {"bigexp", "aliens", "droid", "fire"};
    int num_collections = sizeof(collection_names) / sizeof(collection_names[0]);

    for (int i = 0; i < num_collections; i++)
    {
        if (!load_collection(collection_names[i]))
        {
            fprintf(stderr, "Warning: Failed to load collection: %s\n", collection_names[i]);
            // Continue with other collections
        }
    }

    printf("=== Interpolated Sprites Initialized (%d collections) ===\n\n",
           (int)collections.size());

    return collections.size() > 0;
}

void InterpSpriteManager::shutdown()
{
    printf("Shutting down interpolated sprites\n");

    for (size_t i = 0; i < collections.size(); i++)
    {
        delete collections[i];
    }
    collections.clear();

    enabled = false;
}

bool InterpSpriteManager::load_collection(const char *name)
{
    InterpCollection *coll = new InterpCollection(name);

    if (!coll->load())
    {
        delete coll;
        return false;
    }

    collections.push_back(coll);
    return true;
}

InterpCollection *InterpSpriteManager::find_collection(const char *name)
{
    for (size_t i = 0; i < collections.size(); i++)
    {
        if (collections[i]->name == name)
            return collections[i];
    }
    return NULL;
}

figure *InterpSpriteManager::get_interpolated_figure(const char *collection,
                                                     int physics_frame,
                                                     float render_offset,
                                                     int total_physics_frames)
{
    if (!enabled)
        return NULL;

    InterpCollection *coll = find_collection(collection);
    if (!coll)
        return NULL;

    return coll->get_interpolated_frame(physics_frame, render_offset, total_physics_frames);
}

bool InterpSpriteManager::has_interpolated_data(const char *collection) const
{
    if (!enabled)
        return false;

    for (size_t i = 0; i < collections.size(); i++)
    {
        if (collections[i]->name == collection)
            return !collections[i]->figures.empty();
    }
    return false;
}

//=============================================================================
// Global functions
//=============================================================================

void init_interp_sprites()
{
    if (interp_sprite_manager)
    {
        fprintf(stderr, "Warning: interp_sprite_manager already initialized\n");
        return;
    }

    interp_sprite_manager = new InterpSpriteManager();

    if (settings.interpolated_sprites_enabled)
    {
        interp_sprite_manager->initialize();
    }
}

void shutdown_interp_sprites()
{
    if (interp_sprite_manager)
    {
        delete interp_sprite_manager;
        interp_sprite_manager = NULL;
    }

    last_physics_tick = 0;
    current_render_offset = 0.0f;
}

float get_render_frame_offset()
{
    // Calculate sub-frame timing for smooth interpolation
    // Returns 0.0-1.0 indicating position within current physics frame

    if (!current_level)
        return 0.0f;

    // Get current time from level
    int current_tick = current_level->tick_counter();

    // Physics updates every 65ms (15 FPS)
    const float physics_delta = 65.0f;

    // Calculate time since last physics update
    int delta = current_tick - last_physics_tick;

    // Calculate offset (0.0-1.0)
    float offset = (float)delta / physics_delta;

    // Handle physics tick
    if (offset >= 1.0f)
    {
        last_physics_tick = current_tick;
        offset = 0.0f;
    }

    // Clamp to valid range
    if (offset < 0.0f)
        offset = 0.0f;
    if (offset > 1.0f)
        offset = 1.0f;

    current_render_offset = offset;
    return offset;
}
