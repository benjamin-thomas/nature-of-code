/*

I tried to get better perf by using `fwrite` instead of `fprintf`.
The execution time got worse!

    $ time ./cmake-build-release/c

    real    0m0.046s
    user    0m0.038s
    sys     0m0.005s

 Note that the Rust equivalent is faster (and much simpler to write)!

    $ time ./target/release/rust

    real    0m0.010s
    user    0m0.007s
    sys     0m0.004s
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    float r;
    float g;
    float b;
} Color;

#define colorCnt 3

#pragma clang diagnostic push
#pragma ide diagnostic ignored "OCUnusedGlobalDeclarationInspection"
void generatePattern2(unsigned int imageWidth,
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
    fwrite(ppmMagicNumber, sizeof(char), strlen(ppmMagicNumber), pFile);
    fputc('\n', pFile);

    char tmp[11]; // max uint + '\0'
    snprintf(tmp, sizeof(tmp), "%u", imageWidth);
    fwrite(&tmp, sizeof(char), strlen(tmp), pFile);

    fputc(' ', pFile);
    snprintf(tmp, sizeof(tmp), "%u", imageHeight);
    fwrite(&tmp, sizeof(char), strlen(tmp), pFile);
    fputc('\n', pFile);

    snprintf(tmp, sizeof(tmp), "%u", scale);
    fwrite(&tmp, sizeof(char), strlen(tmp), pFile);
    fputc('\n', pFile);

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
            /*
            fprintf(pFile,
                    "%c%c%c",
                    (unsigned char) (r * (float) scale),
                    (unsigned char) (g * (float) scale),
                    (unsigned char) (b * (float) scale)
            );
             */
            snprintf(tmp, sizeof(tmp), "%c%c%c",
                     (unsigned char) (r * (float) scale),
                     (unsigned char) (g * (float) scale),
                     (unsigned char) (b * (float) scale)
            );
            fwrite(&tmp, sizeof(char), strlen(tmp), pFile);
        }
    }
    fclose(pFile);
}
#pragma clang diagnostic pop

//int main() {
//    const char *filename = "/tmp/white-noise.ppm";
//    generatePattern2(512, 512, filename);
//    printf("Noise generated at: %s\n", filename);
//    return 0;
//}
