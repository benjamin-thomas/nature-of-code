/*

Rust is faster the C++ here

    $ time ./cmake-build-release/cpp

    real    0m0.033s
    user    0m0.033s
    sys     0m0.000s

 */

#include <iostream>
#include <fstream>

struct Color {
    float r;
    float g;
    float b;
};

void generatePattern(unsigned int imageWidth, unsigned int imageHeight, const char *filename) {
    static const unsigned colorCnt = 3;
    Color rockColors[colorCnt] = {
            {0.4078, 0.4078, 0.3764},
            {0.7606, 0.6274, 0.6313},
            {0.8980, 0.9372, 0.9725},
    };
    std::ofstream ofs(filename);

    ofs << "P6\n"
        << imageWidth << " " << imageHeight << "\n"
        << "255\n";

    for (int x = 0; x < imageWidth; ++x) {
        for (int y = 0; y < imageHeight; ++y) {
            // Pickup a random index
            double rand = drand48(); // returns a value between [0.0,1.0) (excluding 1)
            auto randIdx = (unsigned int) (rand * colorCnt); // returns one of: [0, 1, 2]

            // Get the chosen dominent color's RGB values
            float r = rockColors[randIdx].r;
            float g = rockColors[randIdx].g;
            float b = rockColors[randIdx].b;

            // Scale the RGB values to [0.0, 255.0).
            // Then send the equivalent binary (char) data to the write stream.
            ofs << (unsigned char) (r * 255)
                << (unsigned char) (g * 255)
                << (unsigned char) (b * 255);
        }
    }
    ofs.close();
}

int main() {
    const char *filepath = "white-noise.ppm";
    generatePattern(512, 512, filepath);
    std::cout << "Noise generated at: " << filepath << "\n";
    return 0;
}
