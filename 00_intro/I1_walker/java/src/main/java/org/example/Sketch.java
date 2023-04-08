package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {
    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Walker");
        background(0); // black
    }

    @Override
    public void draw() {
        stroke(0, 255, 0); // borders green
        fill(255, 0, 0);
        circle(100, 100, 50);
    }
}
