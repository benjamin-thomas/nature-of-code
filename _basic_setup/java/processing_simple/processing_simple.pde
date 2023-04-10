/*
Run the sketch:
  processing-java --sketch=$PWD --run

Inspect the generated code:
  rm -rf /tmp/sketch ; processing-java --sketch=$PWD --output=/tmp/sketch
--export && bat /tmp/sketch/source/*.java
*/

void settings() { size(640, 360); }

void setup() {
  windowTitle("CHANGE_ME");
  background(0); // black
}

void draw() {
  stroke(0, 255, 0); // borders green
  fill(255, 0, 0);
  circle(100, 100, 50);
}
