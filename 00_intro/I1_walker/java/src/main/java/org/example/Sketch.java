package org.example;

import processing.core.PApplet;

import java.util.Optional;

public class Sketch extends PApplet {

    private Walker walker;
    private final int exercise;

    public Sketch() {
        exercise = getExercise();
    }

    private int getExercise() {
        Optional<String> maybeExercise = Optional.ofNullable(
                System.getProperty("exercise")
        );
        return Integer.parseInt(maybeExercise.orElse("0"));
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
        walker.step(this.exercise);
        walker.display();
    }
}
