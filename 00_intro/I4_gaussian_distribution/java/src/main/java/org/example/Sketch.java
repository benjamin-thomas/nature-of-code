package org.example;

import processing.core.PApplet;

import java.util.Random;

public class Sketch extends PApplet {

    private Random rand;

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void setup() {
        windowTitle("Gaussian distribution");
        rand = new Random();
    }

    @Override
    public void draw() {
        float x = (float) rand.nextGaussian(width / 2d, 60);

        noStroke();
        fill(0, 10);
        circle(x, height / 2f, 16);
    }

}
