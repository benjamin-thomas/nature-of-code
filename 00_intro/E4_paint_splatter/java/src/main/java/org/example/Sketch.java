package org.example;

import processing.core.PApplet;

import java.util.Random;

/*
    Consider a simulation of paint splatter drawn as a collection of colored dots.
    Most of the paint clusters around a central location, but some dots do splatter out towards the edges.
    Can you use a normal distribution of random numbers to generate the locations of the dots?
    Can you also use a normal distribution of random numbers to generate a color palette?
 */

public class Sketch extends PApplet {

    private Random random;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Paint splatter");
        random = new Random();
    }

    @Override
    public void draw() {
        float x = (float) random.nextGaussian(width / 2d, 60);
        float y = (float) random.nextGaussian(height / 2d, 60);

        float r = (float) random.nextGaussian(225, 30); // lots of red
        float g = (float) random.nextGaussian(255 / 2d, 30); // a little less of green (sometimes yellow)
        float b = (float) random.nextGaussian(255 / 2d, 15); // much less blue


        noStroke();
        fill(r, g, b);
        circle(x, y, 16);
    }


}
