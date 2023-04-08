package org.example;

import processing.core.PApplet;

public class Main {
    public static void main(String[] args) {
        /*
            1. Create a random walker that has a tendency to move down and to the right.
            2. Tends to move to the right.
            3. Create a random walker with dynamic probabilities.
               For example, can you give it a 50% chance of moving in the direction of the mouse?
         */
        System.setProperty("exercise", "3");
        PApplet.main("org.example.Sketch");
    }
}