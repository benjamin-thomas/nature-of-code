package org.example;

import processing.core.PApplet;

public class Main {
    public static void main(String[] args) {
        /*
            1. Create a random walker that has a tendency to move down and to the right.
            2. Tends to move to the right.
            3. Create a random walker with dynamic probabilities.
               For example, can you give it a 50% chance of moving in the direction of the mouse?
            5. Implement a variation of our random walk with a normal random distribution.
            6. Use a custom probability distribution to vary the size of a step taken by the random walker.
               The step size can be determined by influencing the range of values picked.
               Can you map the probability exponentially—i.e. making the likelihood that a value is picked equal to the value squared?

               That one was tough. I looked for the answer.
         */
        System.setProperty("exercise", "6");
        PApplet.main("org.example.Sketch");
    }
}