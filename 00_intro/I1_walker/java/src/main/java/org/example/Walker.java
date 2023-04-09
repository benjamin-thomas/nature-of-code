package org.example;

import java.util.Random;

class Walker {
    private final Sketch sketch;
    private final Random random;
    private int x;
    private int y;

    Walker(Sketch sketch) {
        this.sketch = sketch;
        x = sketch.width / 2;
        y = sketch.height / 2;
        random = new Random();
    }

    void step(int exercise) {
        switch (exercise) {
            case 0 -> {
                x += randBetween(-1f, 1f);
                y += randBetween(-1f, 1f);
            }

            case 1 -> {
                x += randBetween(-1f, 1.3f);
                y += randBetween(-1f, 1.3f);
            }

            case 2 -> {
                x += randBetween(-1f, 2f);
                y += randBetween(-1f, 1f);
            }

            case 3 -> {
                float prob = 0.5f;
                if (sketch.mouseX < x) {
                    // Go left
                    x += randBetween(-(1f + prob), 1f);
                } else {
                    // Go right
                    x += randBetween(-1f, (1f + prob));
                }

                if (sketch.mouseY < y) {
                    // Go up
                    y += randBetween(-(1f + prob), 1f);
                } else {
                    // Go down
                    y += randBetween(-1f, (1f + prob));
                }
            }

            case 5 -> {
                double stdDev = 2.5; // the higher the number, the bigger the step + the more the pattern "spreads"
                x += random.nextGaussian(0.4, stdDev); // tends to go left
                y += random.nextGaussian(0.4, stdDev); // tends to go up
            }

            default -> throw new IllegalStateException("Unexpected exercise: " + exercise);
        }

    }

    private int randBetween(@SuppressWarnings("SameParameterValue") float fromInc, float toInc) {
        return (int) Math.floor(sketch.random(fromInc, toInc + 1));
    }

    void display() {
        sketch.stroke(255);
        sketch.point(x, y);
    }

}
