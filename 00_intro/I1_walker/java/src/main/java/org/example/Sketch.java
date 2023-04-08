package org.example;

import processing.core.PApplet;
import processing.event.KeyEvent;

public class Sketch extends PApplet {
    @Override
    public void settings() {
        _settings();
        super.settings();
    }

    @Override
    public void setup() {
        _setup();
        super.setup();
    }

    @Override
    public void draw() {
        _draw();
        super.draw();
    }

    @Override
    protected void handleKeyEvent(KeyEvent event) {
        System.out.println("handleKeyEvent");
        super.handleKeyEvent(event);
    }

    @Override
    public void keyPressed() {
//        if (ke.getKeyCode() == KeyEvent.VK_ESCAPE)
//        super.keyPressed();
//        System.out.println("ke.getKeyCode() = " + ke.getKeyCode());
        System.out.println("key pressed!");
        super.keyPressed();
    }

    private void _settings() {
        size(640, 360);
    }

    private void _setup() {
        background(0); // black
        System.out.println("setup done");
    }

    private void _draw() {
        stroke(0, 255, 0); // borders green
        fill(255, 0, 0);
        circle(100, 100, 50);
    }
}
