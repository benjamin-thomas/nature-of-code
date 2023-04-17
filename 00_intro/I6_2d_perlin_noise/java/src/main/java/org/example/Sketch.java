package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {

    public static float OFFSET = 0.01f;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Perlin Noise 2D");
    }

    @Override
    public void mouseClicked() {
        OFFSET *= 1.05f; // zoom out
    }

    @Override
    public void draw() {
        background(0);

        // Load current data into pixels[]
        loadPixels();
        float xOff = 0;
        for (int x = 0; x < width; x++) {
            float yOff = 0;
            for (int y = 0; y < height; y++) {
                float brightness = map(noise(xOff, yOff), 0, 1, 0, 255);
                pixels[x + y * width] = color(brightness);
                yOff += OFFSET;
            }
            xOff += OFFSET;
        }
        // Apply changes to pixels[]
        updatePixels();
    }

}
