package org.example;

import java.util.Random;

import static processing.core.PApplet.constrain;

class Walker {
    private final Sketch sketch;
    private final Random random;
    private int x;
    private int y;
    private int prevX;
    private int prevY;
    private final boolean simpleLevyFlight = false;

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

            case 6 -> {
                this.prevX = x;
                this.prevY = y;

                if (this.simpleLevyFlight) {
                    var stepSize = 1f;
                    if (random.nextFloat() < 0.08) {
                        stepSize = 15f;
                    }

                    x += randBetween(-stepSize, stepSize);
                    y += randBetween(-stepSize, stepSize);
                } else {
                    float stepX = randBetween(-1, 1);
                    float stepY = randBetween(-1, 1);

                    float stepSize = monteCarlo() * 50;
                    stepX *= stepSize;
                    stepY *= stepSize;

                    x += stepX;
                    y += stepY;
                    x = constrain(x, 0, sketch.width - 1);
                    y = constrain(y, 0, sketch.height - 1);
                }
            }

            default -> throw new IllegalStateException("Unexpected exercise: " + exercise);
        }

    }

    private float monteCarlo() {
        while (true) {
            float r1 = sketch.random(1);
            float prob = (float) Math.pow(1.0 - r1, 8); // x^8

            float r2 = sketch.random(1);
            if (r2 < prob) {
                return r1;
            }
        }
    }

    private int randBetween(@SuppressWarnings("SameParameterValue") float fromInc, float toInc) {
        return (int) Math.floor(sketch.random(fromInc, toInc + 1));
    }

    void display(int exercise) {
        sketch.stroke(255);
        if (exercise == 6) {
            sketch.line(prevX, prevY, x, y);
        } else {
            sketch.point(x, y);
        }
    }

}
