use nannou::prelude::*;

/*
cargo run
cargo run --release
 */

fn main() {
    nannou::app(model).update(update).run();
}

struct Model {
    _window: WindowId,
}

fn model(app: &App) -> Model {
    let _window = app.new_window().size(640, 360).view(view).build().unwrap();
    Model { _window }
}

fn update(_app: &App, _model: &mut Model, _update: Update) {}

fn view(app: &App, _model: &Model, frame: Frame) {
    let draw = app.draw();
    draw.background().color(BLACK);
    let diameter = 50.0;
    draw.ellipse()
        .color(RED)
        .w_h(diameter, diameter)
        .x(-200.0) // to the left. 0 is the center of the window.
        .y(100.0); // to the top. 0 is the center of the window.
    draw.to_frame(app, &frame).unwrap();
}
