package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {
    public static final double X_SPEED = 0.01; // this affects the x scroll speed: the lower, the slower.
    public static final double FLATTENING = 0.002; // this value affects the flattening: the lower, the flatter
    private float t = 0;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Perlin Noise");

        stroke(255);
        strokeWeight(2);
        noFill();
    }

    @Override
    public void draw() {
        update();
        background(0); // clear previous render
        drawGraph();
    }

    private void update() {
        t += X_SPEED;
    }

    private void drawGraph() {
        float xoff = t;
        beginShape();
        for (int x = 0; x < width; x++) {
            float y = noise(xoff) * height;
            vertex(x, y);
            xoff += FLATTENING;
        }
        endShape();
    }
}
