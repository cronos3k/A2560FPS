/*
 *  Abuse 2025 Modern Launcher
 *  Copyright (c) 2025 AI-Enhanced Development
 *
 *  Launcher executable that enables all modern features by default
 *  and then launches the main game executable.
 */

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Modern default settings for Abuse 2025
void create_modern_config()
{
    FILE *config = fopen("config_2025.txt", "w");
    if (!config)
    {
        MessageBox(NULL, "Failed to create modern config file", "Abuse 2025", MB_OK | MB_ICONERROR);
        return;
    }

    fprintf(config, "; Abuse 2025 - Modern Configuration\n");
    fprintf(config, "; This config enables all modern features for the best experience\n\n");

    fprintf(config, "; SCREEN\n");
    fprintf(config, "screen_width=1920\n");
    fprintf(config, "screen_height=1080\n");
    fprintf(config, "virtual_width=640\n");
    fprintf(config, "virtual_height=480\n");
    fprintf(config, "fullscreen=0\n");
    fprintf(config, "borderless=1\n");
    fprintf(config, "vsync=1\n");
    fprintf(config, "linear_filter=1\n");
    fprintf(config, "hires=1\n\n");

    fprintf(config, "; FRAME PACING\n");
    fprintf(config, "fps_limit=60\n\n");

    fprintf(config, "; GAMEPLAY - MODERN FEATURES ENABLED\n");
    fprintf(config, "; Enable wall jump mechanics (optional gameplay feature)\n");
    fprintf(config, "wall_jump_enabled=1\n");
    fprintf(config, "; Wall jump grace window after letting go of the wall (frames)\n");
    fprintf(config, "wall_coyote_frames=60\n");
    fprintf(config, "; Hold toward-wall time before latching (frames)\n");
    fprintf(config, "wall_hang_hold_frames=12\n\n");

    fprintf(config, "; DEBUG\n");
    fprintf(config, "; Show wall-hang debug overlay (Alt+N toggles in-game)\n");
    fprintf(config, "wall_debug_overlay=0\n");
    fprintf(config, "; Enable light/glow overlay for particles/explosions\n");
    fprintf(config, "lights_overlay_enabled=1\n");
    fprintf(config, "; Enable AI-interpolated 60 FPS sprite animations (requires interpolated sprite data in AIWork/frame-interpolation/final/)\n");
    fprintf(config, "interpolated_sprites_enabled=1\n\n");

    fprintf(config, "; SOUND\n");
    fprintf(config, "mono=0\n");
    fprintf(config, "no_sound=0\n");
    fprintf(config, "no_music=0\n");
    fprintf(config, "volume_sound=127\n");
    fprintf(config, "volume_music=127\n");
    fprintf(config, "soundfont=AWE64 Gold Presets.sf2\n\n");

    fprintf(config, "; CONTROLS - MODERN LAYOUT\n");
    fprintf(config, "left=a\n");
    fprintf(config, "right=d\n");
    fprintf(config, "up=w\n");
    fprintf(config, "down=s\n");
    fprintf(config, "special=SHIFT_L\n");
    fprintf(config, "fire=f\n");
    fprintf(config, "weapon_prev=q\n");
    fprintf(config, "weapon_next=e\n");
    fprintf(config, "special2=CTRL_L\n");
    fprintf(config, "; Dedicated jump key (spacebar)\n");
    fprintf(config, "jump=SPACE\n\n");

    fprintf(config, "; MISC\n");
    fprintf(config, "local_save=1\n");
    fprintf(config, "grab_input=0\n");
    fprintf(config, "editor=0\n");
    fprintf(config, "bullet_time_add=50\n");
    fprintf(config, "player_touching_console=1\n\n");

    fclose(config);
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    // Create modern config file
    create_modern_config();

    // Get the directory where this launcher is located
    char path[MAX_PATH];
    GetModuleFileName(NULL, path, MAX_PATH);

    // Remove the filename to get just the directory
    char *last_slash = strrchr(path, '\\');
    if (last_slash)
        *last_slash = '\0';

    // Build the path to abuse.exe
    char exe_path[MAX_PATH];
    snprintf(exe_path, MAX_PATH, "%s\\abuse.exe", path);

    // Build command line with config override
    char cmdline[MAX_PATH + 100];
    snprintf(cmdline, sizeof(cmdline), "\"%s\" -config config_2025.txt %s", exe_path, lpCmdLine);

    // Launch the main game
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    if (!CreateProcess(
            NULL,           // No module name (use command line)
            cmdline,        // Command line
            NULL,           // Process handle not inheritable
            NULL,           // Thread handle not inheritable
            FALSE,          // Set handle inheritance to FALSE
            0,              // No creation flags
            NULL,           // Use parent's environment block
            path,           // Use launcher's directory as current directory
            &si,            // Pointer to STARTUPINFO structure
            &pi))           // Pointer to PROCESS_INFORMATION structure
    {
        char error_msg[512];
        snprintf(error_msg, sizeof(error_msg),
                 "Failed to launch abuse.exe\n\nPath: %s\n\nMake sure abuse.exe is in the same directory as abuse25.exe",
                 exe_path);
        MessageBox(NULL, error_msg, "Abuse 2025 Launcher Error", MB_OK | MB_ICONERROR);
        return 1;
    }

    // Close process and thread handles
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}
