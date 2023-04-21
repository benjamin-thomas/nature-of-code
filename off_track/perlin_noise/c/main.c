#include <stdio.h>
#include <stdlib.h>

typedef struct {
    float r;
    float g;
    float b;
} Color;

#define colorCnt 3
void generatePattern(unsigned int imageWidth,
                     unsigned int imageHeight,
                     const char *filename) {
    char *ppmMagicNumber = "P6";
    int scale = 255;
    Color rockColors[colorCnt] = {
            {0.4078f, 0.4078f, 0.3764f},
            {0.7606f, 0.6274f, 0.6313f},
            {0.8980f, 0.9372f, 0.9725f},
    };

    FILE *const pFile = fopen(filename, "wb");
    fprintf(pFile,
            "%s\n"
            "%d %d\n"
            "%d\n",
            ppmMagicNumber,
            imageWidth, imageHeight,
            scale);

    for (int x = 0; x < imageWidth; ++x) {
        for (int y = 0; y < imageHeight; ++y) {
            // Pickup a random index
            double rand = drand48(); // returns a value between [0.0,1.0) (excluding 1)
            unsigned int randIdx = (unsigned int) (rand * colorCnt); // returns one of: [0, 1, 2]

            // Get the chosen dominent color's RGB values
            float r = rockColors[randIdx].r;
            float g = rockColors[randIdx].g;
            float b = rockColors[randIdx].b;

            // Scale the RGB values to [0.0, 255.0).
            // Then send the equivalent binary (char) data to the write stream.
            fprintf(pFile,
                    "%c%c%c",
                    (unsigned char) (r * (float) scale),
                    (unsigned char) (g * (float) scale),
                    (unsigned char) (b * (float) scale)
            );
        }
    }
    fclose(pFile);
}

int main() {
    const char *filename = "white-noise.ppm";
    generatePattern(512, 512, filename);
    printf("Noise generated at: ./cmake-build-debug/%s\n", filename);
    return 0;
}
