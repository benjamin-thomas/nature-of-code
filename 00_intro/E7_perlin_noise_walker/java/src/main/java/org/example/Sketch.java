package org.example;

import processing.core.PApplet;
import processing.core.PVector;

public class Sketch extends PApplet {

    private Walker[] walkers;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Perlin Noise Walker (Java/Processing)");
        walkers = new Walker[]{
                new Walker(0f, 10_000f),
                new Walker(15_000f, 25_000f),
//                new Walker(30_000f, 40_000f),
//                new Walker(45_000f, 55_000f),
//                new Walker(60_000f, 70_000f),
        };
    }

    @Override
    public void draw() {
        background(0); // clear previous renders
        stroke(255);
        strokeWeight(2);

        for (Walker walker : walkers) {
            walker.step();
            walker.render();
        }
    }

    class Walker {
        private int cursor;
        private float tx, ty;
        private final PVector[] points = new PVector[25]; // adjust trail size here

        Walker(float tx, float ty) {
            this.tx = tx;
            this.ty = ty;
            this.cursor = 0;
            step();
        }

        void step() {
            float x = map(noise(tx), 0, 1, 0, width);
            float y = map(noise(ty), 0, 1, 0, height);

            points[this.cursor] = new PVector(x, y);
            this.cursor++;


            // Clear trail once buffer has been filled.
            if (this.cursor >= points.length) {
                // shift all by one (clear first data point)
                for (int i = 1; i < points.length; i++) {
                    points[i - 1] = points[i];
                }
                // backtrack
                this.cursor--;
            }

            tx += 0.005f;
            ty += 0.005f;
        }

        void render() {
            for (int i = 1; i < points.length; i++) {
                PVector v = points[i];
                if (v == null) break; // buffer not filled yet

                PVector prev = points[i - 1];

                // Make the trail fainter and fainter
                float progression = i / ((float) points.length);
                float alpha = 255 * progression;
                stroke(255, 255, 255, alpha);

                line(prev.x, prev.y, v.x, v.y);
            }
        }

    }
}
