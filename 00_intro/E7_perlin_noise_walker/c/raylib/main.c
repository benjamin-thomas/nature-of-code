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
#include "noise1234.h"

// A static global variable or a function is "seen" only in the file it's declared in
static const int
        screenWidth = 800,
        screenHeight = 450;

static int cursor = 0;

static const float
        SPEED = 0.015f;

static float
        tx = 0, ty = 10000;


#define TRAIL_SIZE 50
static Vector2 points[TRAIL_SIZE];

void update() {
    float x = noise1(tx) * (float) screenWidth / 2;
    x += (float) screenWidth / 2;

    float y = noise1(ty) * (float) screenHeight / 2;
    y += (float) screenHeight / 2;

    tx += SPEED;
    ty += SPEED;
    points[cursor] = (Vector2) {x, y};
    cursor++;

    // Remove old points once buffer has been filled (= trail)
    if (cursor >= TRAIL_SIZE) {
        // shift all by one
        for (int i = 1; i < TRAIL_SIZE; ++i) {
            points[i - 1] = points[i];
        }
        // backtrack
        cursor--;
    }
}

void draw() {
    ClearBackground(BLACK);

    for (int i = 1; i < TRAIL_SIZE; ++i) {
        Vector2 v = points[i];
        Vector2 prev = points[i - 1];

        if (v.x == 0.0f && v.y == 0.0f) break; // buffer not filled yet

        float progression = (float) i / (float) TRAIL_SIZE;
        Color color = ColorAlpha(WHITE, progression);
        DrawLineEx(prev, v, 2.0f, color);
    }
}

int main() {
    SetConfigFlags(FLAG_MSAA_4X_HINT);
    InitWindow(screenWidth, screenHeight, "C/Raylib: Perlin Noise Walker");

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