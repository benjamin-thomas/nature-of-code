package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {

    private Walker walker;
    private Walker walker2;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Perlin Noise Walker");
        background(0); // black
        walker = new Walker(0f, 10_000f);
        walker2 = new Walker(54321f, 77_654f);
    }

    @Override
    public void draw() {
        walker.step();
        walker.render();

        walker2.step();
        walker2.render();
    }

    class Walker {
        private float tx, ty;
        private float x, y;
        private float prevX, prevY;

        Walker(float tx, float ty) {
            this.tx = tx;
            this.ty = ty;
            x = map(noise(this.tx), 0, 1, 0, width);
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

            // Make trail finite
            noStroke();
            fill(0, 30);
            rect(0, 0, width, height);

            // Really clear. A faint trail remains indefinitely otherwise.
            if (frameCount % 30 == 0) background(0);
        }

    }
}
