use macroquad::prelude::*;

#[macroquad::main("Macroquad project")]
async fn main() {
    while !is_key_down(KeyCode::Escape) {
        render().await
    }
}

async fn render() {
    clear_background(BLACK);

    draw_circle(100.0, 100.0, 25.0, YELLOW);

    next_frame().await
}
