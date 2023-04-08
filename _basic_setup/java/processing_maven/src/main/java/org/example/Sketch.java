package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {
    @Override
    public void settings() {
        _settings();
        super.settings();
    }

    @Override
    public void setup() {
        _setup();
        super.setup();
    }

    @Override
    public void draw() {
        _draw();
        super.draw();
    }

    private void _settings() {
        size(640, 360);
    }

    private void _setup() {
        background(0); // black
    }

    private void _draw() {
        stroke(0, 255, 0); // borders green
        fill(255, 0, 0);
        circle(100, 100, 50);
    }
}
