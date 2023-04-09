#include <raylib.h>

/*
    cmake -B cmake-build-debug/ && make -C cmake-build-debug && cmake-build-debug/Raylib_project
 */

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 360;
const char *SCREEN_TITLE = "Raylib project";

int main() {
    // Init
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE);

    // Game loop
    while (!WindowShouldClose()) {
        // Update

        // Render
        BeginDrawing();
        ClearBackground(BLACK);

        DrawCircle(100, 100, 25, RED);

        EndDrawing();
    }

    // Cleanup
    CloseWindow();
    return 0;
}
