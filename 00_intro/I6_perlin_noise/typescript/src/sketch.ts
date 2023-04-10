import p5 from "p5";

let t = 0;

new p5((p: p5) => {

  p.setup = () => {
    p.createCanvas(640,360);

    // Defaults
    p.stroke(255);
    p.strokeWeight(2);
    p.noFill();
  };

  p.draw = () => {
    // Update
    t += 0.02; // adjust speed (the lower, the slower)

    p.background(0) // clear previous render
    let xOff = t;
    p.beginShape()
    for (let x = 0; x < p.width; x++) {
      const y = p.noise(xOff) * p.height;
      p.vertex(x, y);
      xOff += 0.005; // adjust flattening (the lower, the flatter)
    }
    p.endShape()
  };
});
