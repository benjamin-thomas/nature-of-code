
Walker[] walkers;

void settings() { size(640, 360); }

void setup() {
  windowTitle("Perlin Noise Walker");
  background(0); // black
  walkers = new Walker[]{
      new Walker(0f, 10_000f),
      new Walker(15_000f, 25_000f),
  };
}

void draw() {
  for (Walker walker : walkers) {
    walker.step();
    walker.render();
  }
}

class Walker {
  float tx, ty;
  float x, y;
  float prevX, prevY;

  Walker(float tx, float ty) {
    this.tx = tx;
    this.ty = ty;
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

    // Make trail finite
    noStroke();
    fill(0, 30);
    rect(0, 0, width, height);

    // Really clear. A faint trail remains indefinitely otherwise.
    if (frameCount % 60 == 0)
      background(0);
  }
}