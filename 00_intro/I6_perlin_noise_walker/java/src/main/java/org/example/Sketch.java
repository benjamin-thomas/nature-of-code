package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {

    private Walker walker;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Perlin Noise Walker");
        background(0); // black
        walker = new Walker();
    }

    @Override
    public void draw() {
        walker.step();
        walker.render();
    }

    class Walker {
        private float tx, ty;
        private float x, y;
        private float prevX, prevY;

        Walker() {
            tx = 0f;
            ty = 10_000f;
            x = map(noise(tx), 0, 1, 0, width);
            y = map(noise(ty), 0, 1, 0, height);
        }

        void step() {
            prevX = x;
            prevY = y;

            x = map(noise(tx), 0, 1, 0, width);
            y = map(noise(ty), 0, 1, 0, height);

            tx += 0.01f;
            ty += 0.01f;
        }

        void render() {
            stroke(255);
            line(prevX, prevY, x, y);
        }

    }
}
