package org.example;

class Walker {
    private final Sketch sketch;
    private int x;
    private int y;

    Walker(Sketch sketch) {
        this.sketch = sketch;
        x = sketch.width / 2;
        y = sketch.height / 2;
    }

    void step(boolean isExercise) {
        float toInc = 1f;
        if (isExercise) toInc = 1.1f;
        x += randBetween(-1f, toInc);
        y += randBetween(-1f, toInc);
    }

    private int randBetween(@SuppressWarnings("SameParameterValue") float fromInc, float toInc) {
        return (int) Math.floor(sketch.random(fromInc, toInc + 1));
    }

    void display() {
        sketch.stroke(255);
        sketch.point(x, y);
    }

}
