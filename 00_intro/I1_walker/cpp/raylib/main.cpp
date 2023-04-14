#include <raylib.h>
#include <random>

/*
    cmake -B cmake-build-debug/ && ninja -C cmake-build-debug && cmake-build-debug/Raylib_project
 */

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 360;
const char *SCREEN_TITLE = "Raylib project";

std::mt19937 gen(std::random_device{}());

int randInt(int minVal, int maxVal) {
    std::uniform_int_distribution<> dist(minVal, maxVal);
    return dist(gen);
}


class Walker {
    int x;
    int y;

public:
    Walker() {
        x = SCREEN_WIDTH / 2;
        y = SCREEN_HEIGHT / 2;
    }

    void step() {
        x += randInt(-1, 1);
        y += randInt(-1, 1);
    }

    void display() {
        DrawPixel(x, y, WHITE);
    }
};

int main() {
    // Init
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE);
    SetTargetFPS(120);
    Walker *w = new Walker();

    // Game loop
    while (!WindowShouldClose()) {
        // Update
        w->step();

        // Render
        BeginDrawing();
        w->display();
        EndDrawing();
    }

    // Cleanup
    CloseWindow();
    return 0;
}
