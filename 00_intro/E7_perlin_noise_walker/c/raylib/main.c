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

#include <stdlib.h>
#include "raylib.h"
#include "noise1234.h"

// A static global variable or a function is "seen" only in the file it's declared in
static const int
        SCREEN_WIDTH = 800,
        SCREEN_HEIGHT = 450;

static const float
        STEP_SIZE = 0.04f; // this value affects the speed (and the FPS too)

#define TRAIL_SIZE 50

typedef struct Walker {
    float tx, ty;
    int cursor;
    struct Vector2 points[TRAIL_SIZE];
    Color color;
} Walker;

void stepWalker(Walker *pWalker) {
    float noiseX = noise1(pWalker->tx);
    float x = noiseX * (float) SCREEN_WIDTH / 2.0f;
    x += (float) SCREEN_WIDTH / 2.0f;

    float noiseY = noise1(pWalker->ty);
    float y = noiseY * (float) SCREEN_HEIGHT / 2.0f;
    y += (float) SCREEN_HEIGHT / 2.0f;

    pWalker->points[pWalker->cursor] = (Vector2) {x, y};

    bool allVectorsSet = pWalker->cursor >= TRAIL_SIZE - 1;
    if (!allVectorsSet) {
        pWalker->cursor++;
    } else {
        // Shift all by one
        for (int i = 1; i < TRAIL_SIZE; ++i) {
            pWalker->points[i - 1] = pWalker->points[i];
        }
    }

    pWalker->tx += STEP_SIZE;
    pWalker->ty += STEP_SIZE;
}

void drawWalker(Walker *pWalker) {
    for (int i = 1; i < TRAIL_SIZE; ++i) {
        struct Vector2 v = pWalker->points[i];
        struct Vector2 prev = pWalker->points[i - 1];

        bool vectorNotSetYet = i >= pWalker->cursor;
        if (vectorNotSetYet) break;

        float progression = (float) i / (float) TRAIL_SIZE;
        Color color = ColorAlpha(pWalker->color, progression);

        DrawLineEx(prev, v, 2.0f, color);
    }
}

int main(int argc, char *argv[]) {
    int fps = 60;
    if (argc > 1) {
        char *endToken;
        int n = (int) strtol(argv[1], &endToken, 10);
        if (*endToken == '\0') fps = n;
    }
    SetConfigFlags(FLAG_MSAA_4X_HINT);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "C/Raylib: Perlin Noise Walker");
    SetTargetFPS(fps);

    struct Walker walkers[] = {
            {.tx = 0.0f, .ty = 10000.0f, .cursor = 0, .color = RED},
            {.tx = 15000.0f, .ty = 25000.0f, .cursor = 0, .color = ORANGE},
    };

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(BLACK);

        for (int i = 0; i < sizeof(walkers) / sizeof(walkers[0]); ++i) {
            struct Walker *pWalker = &walkers[i];
            stepWalker(pWalker);
            drawWalker(pWalker);
        }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}