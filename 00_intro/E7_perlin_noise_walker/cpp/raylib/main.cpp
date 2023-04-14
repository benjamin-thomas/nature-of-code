#include <raylib.h>
#include <random>
#include "PerlinNoise.hpp"

/*
    cmake -B cmake-build-debug/ && make -C cmake-build-debug && cmake-build-debug/Raylib_project
    for TIME in 1 2;do ./cmake-build-debug/Raylib_project & done
 */

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 360;
const char *SCREEN_TITLE = "Perlin Noise Walker (C++/Raylib)";

std::random_device rd;
std::mt19937 generator(rd());

static const uint PERLIN_SEED = rd();

const siv::PerlinNoise::seed_type seed = PERLIN_SEED;
const siv::PerlinNoise perlin{seed};

static const int TRAIL_SIZE = 50;

static const double SPEED = 0.006;

class Walker {
    float tx, ty;
    int cursor;
    Vector2 points[TRAIL_SIZE]{};

public:
    Walker(float tx, float ty) {
        this->cursor = 0;
        this->tx = tx;
        this->ty = ty;
        step();
    }

    void step() {
        float x = (float) perlin.noise1D_01(tx) * SCREEN_WIDTH;
        float y = (float) perlin.noise1D_01(ty) * SCREEN_HEIGHT;

        points[this->cursor] = Vector2{x, y};
        this->cursor++;

        // Remove old points once buffer has been filled (= trail)
        if (this->cursor >= TRAIL_SIZE) {
            // shift all by one
            for (int i = 1; i < TRAIL_SIZE; ++i) {
                points[i - 1] = points[i];
            }
            // backtrack
            this->cursor--;
        }

        tx += SPEED;
        ty += SPEED;
    }

    void display() const {
        for (int i = 1; i < TRAIL_SIZE; ++i) {
            Vector2 v = points[i];
            Vector2 prev = points[i - 1];

            if (v.x == 0.0f && v.y == 0.0f) break; // buffer not filled yet

            float progression = (float) i / (float) TRAIL_SIZE;
            auto color = ColorAlpha(WHITE, progression);

            DrawLineEx(prev, v, 2.0f, color);
        }
    }
};

int main() {
    // Init
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE);
    SetTargetFPS(120);
//    auto *w = new Walker(0, 10'000);

    Walker *walkers[] = {
            new Walker(0, 10'000),
            new Walker(15'000, 25'000),
    };

    // Game loop
    while (!WindowShouldClose()) {
        // Update
        for (const auto &w: walkers) {
            w->step();
        }

        // Render
        BeginDrawing();
        ClearBackground(BLACK);
        for (const auto &w: walkers) {
            w->display();
        }
        EndDrawing();
    }

    // Cleanup
    CloseWindow();
    return 0;
}
