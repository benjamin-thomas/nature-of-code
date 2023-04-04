import p5 from "p5";

new p5((p: p5) => {

  class Walker {
    constructor(
      public x: number,
      public y: number,
    ) { }

    step(): void {
      const stepX = Math.floor(Math.random() * 3) - 1; // -1, 0, 1
      const stepY = Math.floor(Math.random() * 3) - 1; // -1, 0, 1
      this.x += stepX;
      this.y += stepY;
    }

    display(): void {
      p.stroke(0);
      p.point(this.x, this.y);
    }
  }

  // Initialize the walker at the screen's center
  const walker = new Walker(p.windowWidth / 2, p.windowHeight / 2);

  p.setup = () => {
    p.createCanvas(p.windowWidth, p.windowHeight);
    p.background(255);
  };

  p.draw = () => {
    walker.step();
    walker.display();
  };
});
