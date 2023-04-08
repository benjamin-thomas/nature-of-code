package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {
    private int[] randomCounts;

    @Override
    public void settings() {
        size(640, 240);
    }

    @Override
    public void setup() {
        windowTitle("Random Distribution");
        randomCounts = new int[20];
    }

    private void update() {
        int idx = (int) random(randomCounts.length);
        randomCounts[idx]++;
    }

    @Override
    public void draw() {
        update();

        background(255);
        stroke(0);
        fill(175);

        drawDistribution();
    }

    private void drawDistribution() {
        int rectWidth = width / randomCounts.length;
        for (int i = 0; i < randomCounts.length; i++) {
            int rectHeight = randomCounts[i];
            int x = i * rectWidth;
            int y = height - rectHeight;
            rect(x, y, rectWidth, rectHeight);
        }
    }
}
