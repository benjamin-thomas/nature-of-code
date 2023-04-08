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
        windowTitle("Walker");
        background(0); // black
        walker = new Walker(this);
    }

    @Override
    public void draw() {
        walker.step();
        walker.display();
    }
}
