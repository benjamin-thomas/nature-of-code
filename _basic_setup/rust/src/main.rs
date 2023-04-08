use ggez::conf::{WindowMode, WindowSetup};
use ggez::{
    event,
    glam::*,
    graphics::{self, Color},
    Context, GameResult,
};
use ggez::graphics::{Mesh};

struct MainState {
    pos_x: f32,
    circle: Mesh,
}

impl MainState {
    fn new(ctx: &mut Context) -> GameResult<MainState> {
        let circle = Mesh::new_circle(
            ctx,
            graphics::DrawMode::fill(),
            vec2(100.0, 0.0), // x always resets at 100 (= pos.x at 0)
            25.0,
            0.1,
            Color::RED,
        )?;

        Ok(MainState { pos_x: 0.0, circle })
    }
}

impl event::EventHandler<ggez::GameError> for MainState {
    fn update(&mut self, _ctx: &mut Context) -> GameResult {
        self.pos_x = self.pos_x % 320.0 + 0.3;
        Ok(())
    }

    fn draw(&mut self, ctx: &mut Context) -> GameResult {
        let bg_color = Color::BLACK;
        let mut canvas = graphics::Canvas::from_frame(ctx, bg_color);

        canvas.draw(&self.circle, Vec2::new(self.pos_x, 100.0));
        canvas.finish(ctx)?;
        Ok(())
    }
}

pub fn main() -> GameResult {
    let cb = ggez::ContextBuilder::new("demo", "me")
        .window_setup(WindowSetup::default().title("GGEZ project"))
        .window_mode(WindowMode::default().dimensions(640.0, 360.0));

    let (mut ctx, event_loop) = cb.build()?;
    let state = MainState::new(&mut ctx)?;
    event::run(ctx, event_loop, state)
}
