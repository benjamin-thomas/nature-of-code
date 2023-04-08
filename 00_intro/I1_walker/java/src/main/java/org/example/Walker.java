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

    void step() {
        x += randBetween(-1, 1);
        y += randBetween(-1, 1);
    }

    @SuppressWarnings("SameParameterValue")
    private int randBetween(int lowInc, int highInc) {
        return (int) Math.floor(sketch.random(lowInc, highInc + 1));
    }

    void display() {
        sketch.stroke(255);
        sketch.point(x, y);
    }

}
