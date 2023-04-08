package org.example;

import processing.core.PApplet;

public class Sketch extends PApplet {

    private Walker walker;
    private final boolean isExercise;

    public Sketch() {
        isExercise = "1".equals(System.getProperty("exercise"));
    }

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
        walker.step(this.isExercise);
        walker.display();
    }
}
