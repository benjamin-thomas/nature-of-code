/*
 2 options to build/run:

     1. Use cmake only

         cmake -B build
         cmake --build ./build
         ./build/RaylibProject

     2. Use cmake + ninja (Clion style)

        cmake -B cmake-build-debug/
        ninja -C cmake-build-debug
        cmake-build-debug/RaylibProject
 */

#include "raylib.h"

// A static global variable or a function is "seen" only in the file it's declared in
static int screenWidth = 800;
static int screenHeight = 450;

static int x = 0;
static int y = 0;

void update();

void draw(void) {
    ClearBackground(BLACK);
    DrawCircle(x, y, 25, RED);
}

int main() {
    InitWindow(screenWidth, screenHeight, "C/Raylib: CHANGE_ME");

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        update();
        draw();
        EndDrawing();
    }

    CloseWindow();

    return 0;
}

void update() {
    x++;
    if (x % 2 == 0) y++;
}


