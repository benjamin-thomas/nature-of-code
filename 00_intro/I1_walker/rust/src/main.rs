use nannou::prelude::*;

/*
cargo run
cargo run --release
 */

fn main() {
    nannou::app(model).update(update).run();
}

struct Walker {
    x: f32,
    y: f32,
}

impl Walker {
    fn step(&mut self) {
        self.x += Self::rand_step();
        self.y += Self::rand_step();
    }

    fn rand_step() -> f32 {
        random_range(-1, 2) as f32 // -1, 0, 1
    }
}

struct Model {
    _window: WindowId,
    walker: Walker,
}

fn model(app: &App) -> Model {
    let _window = app.new_window().size(640, 360).view(view).build().unwrap();
    Model {
        _window,
        walker: Walker { x: 0.0, y: 0.0 }, // 0 is the center of the window.
    }
}

fn update(_app: &App, model: &mut Model, _update: Update) {
    model.walker.step();
}

fn view(app: &App, model: &Model, frame: Frame) {
    let draw = app.draw();
    let walker = &model.walker;
    let size = 1.0;

    draw.rect()
        .color(WHITE)
        .w_h(size, size)
        .x_y(walker.x, walker.y);

    draw.to_frame(app, &frame).unwrap();
}
