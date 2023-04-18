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

#include <stdio.h>
#include "raylib.h"
#include "noise1234.h"

// A static global variable or a function is "seen" only in the file it's declared in
static const int
        SCREEN_WIDTH = 800,
        SCREEN_HEIGHT = 450;

static int cursor = 0;

static const float
        SPEED = 0.015f;

#define TRAIL_SIZE 50

typedef struct Walker {
    float tx, ty;
    int cursor;
    struct Vector2 points[TRAIL_SIZE];
} Walker;

void step_walker(Walker *walker) {
    printf("step start: tx=%f\n", walker->tx);
    float noiseX = noise1(walker->tx);
    float x = noiseX * (float) SCREEN_WIDTH / 2.0f;
    x += (float) SCREEN_WIDTH / 2.0f;

    float noiseY = noise1(walker->ty);
    float y = noiseY * (float) SCREEN_HEIGHT / 2.0f;
    y += (float) SCREEN_HEIGHT / 2.0f;

    walker->points[walker->cursor] = (Vector2) {x, y};
    walker->cursor++;

    // Remove old points once buffer has been filled (= trail)
    if (walker->cursor >= TRAIL_SIZE) {
        // shift all by one
        for (int i = 0; i < TRAIL_SIZE - 1; ++i) {
            walker->points[i] = walker->points[i + 1];
        }
        // backtrack
        walker->cursor--;
    }

    walker->tx += SPEED;
    walker->ty += SPEED;
    printf("step end: tx=%f\n", walker->tx);
}

void update(struct Walker (*walkers)[2]) {
    for (int i = 0; i < 2; ++i) {
        struct Walker *w = walkers[i];
        printf("Updating walker n°%d: tx=%f\n", i, w->tx);
        step_walker(w);
    }
}

void draw(struct Walker (*walkers)[2]) {
    ClearBackground(BLACK);

    for (int i = 0; i < 2; ++i) {
        struct Walker *w = walkers[i];
//        printf("Drawing walker n°%d: (%f, %f)\n", i, w->points[0].x, w->points[0].y);

        for (int j = 1; j < TRAIL_SIZE; ++j) {
            struct Vector2 v = w->points[j];
            struct Vector2 prev = w->points[j - 1];
//            printf("%d] p=%d prev=next=(%f, %f) v=(%f, %f)\n", i, j, prev.x, prev.y, v.x, v.y);

            if (v.x == 0.0f && v.y == 0.0f) return; // buffer not filled yet

//            float progression = (float) j / (float) TRAIL_SIZE;

//            Color color;
//            if (i == 0) {
//                color = ColorAlpha(WHITE, progression);
//            } else {
//                color = ColorAlpha(RED, progression);
//            }


            DrawLineEx(prev, v, 2.0f, RED);
        }
    }
}

int main() {
    SetConfigFlags(FLAG_MSAA_4X_HINT);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "C/Raylib: Perlin Noise Walker");
    SetTargetFPS(60);

    struct Walker walkers[] = {
            {.tx = 0.0f, .ty = 10000.0f, .cursor = 0},
            {.tx = 15000.0f, .ty = 25000.0f, .cursor = 0}
    };

    while (!WindowShouldClose()) {
        BeginDrawing();
//        update();
        update(&walkers);
        draw(&walkers);
//        draw();
        EndDrawing();
    }

    CloseWindow();
    return 0;
}