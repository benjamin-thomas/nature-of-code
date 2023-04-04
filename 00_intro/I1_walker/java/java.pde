class Walker {
  int x;
  int y;

  Walker() {
    x = width / 2;
    y = height / 2;
  }

  void step() {
    int stepX = int(random(3)) - 1; // -1, 0, 1
    int stepY = int(random(3)) - 1; // -1, 0, 1
    x += stepX;
    y += stepY;
  }

  void display() {
    stroke(0);
    point(x, y);
  }
}

Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}
