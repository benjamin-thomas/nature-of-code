
Walker walker;

void settings() { size(640, 360); }

void setup() {
  windowTitle("Perlin Noise Walker");
  background(0);
  walker = new Walker();
}

void draw() {
  walker.step();
  walker.render();
}

class Walker {
  float tx, ty;
  float x, y;
  float prevX, prevY;

  Walker() {
    tx = 0;
    ty = 10_000;
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
  }

  void step() {
    prevX = x;
    prevY = y;

    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);

    tx += 0.01f;
    ty += 0.01f;
  }

  void render() {
    stroke(255);
    line(prevX, prevY, x, y);
  }
}