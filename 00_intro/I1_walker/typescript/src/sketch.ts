import p5 from "p5";

new p5((p: p5) => {

  class Walker {
    constructor(
      public x: number,
      public y: number,
    ) { }

    step(): void {
      const randNum = () => p.random([-1, 0, 1]);

      this.x += randNum();
      this.y += randNum();
    }

    display(): void {
      p.point(this.x, this.y);
    }
  }

  // Initialize the walker at the screen's center
  const walker = new Walker(p.windowWidth / 2, p.windowHeight / 2);

  p.setup = () => {
    p.createCanvas(p.windowWidth, p.windowHeight);
    p.background(0);
    p.stroke(255);
  };

  p.draw = () => {
    walker.step();
    walker.display();
  };
});
