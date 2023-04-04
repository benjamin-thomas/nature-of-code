import p5 from "p5";


new p5((p: p5) => {

  p.setup = () => {
    p.createCanvas(p.windowWidth, p.windowHeight);
    p.background(255); // white
  };

  p.draw = () => {
    p.stroke(0); // borders black
    p.circle(100, 100, 50);
    p.fill(255, 0, 0);
  };
});
