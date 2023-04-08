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
        System.out.println("setup!");
        super.setup();
    }

    @Override
    public void draw() {
        _draw();
        super.draw();
    }

    @Override
    public void keyPressed() {
        System.out.println("keyPressed!");
        super.keyPressed();
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
