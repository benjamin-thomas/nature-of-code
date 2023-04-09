use tetra::graphics::mesh::{GeometryBuilder, Mesh, ShapeStyle};
use tetra::graphics::Color;
use tetra::math::Vec2;
use tetra::{graphics, Context, ContextBuilder, State, TetraError};

struct Game {
    complex: Mesh,
}

impl Game {
    fn new(ctx: &mut Context) -> tetra::Result<Game> {
        let complex = GeometryBuilder::new()
            .set_color(Color::RED)
            .circle(ShapeStyle::Fill, Vec2::new(100.0, 100.0), 64.0)?
            .set_color(Color::GREEN)
            .circle(ShapeStyle::Fill, Vec2::new(200.0, 200.0), 8.0)?
            .build_mesh(ctx)?;

        Ok(Game { complex })
    }
}

impl State for Game {
    fn draw(&mut self, ctx: &mut Context) -> Result<(), TetraError> {
        graphics::clear(ctx, Color::rgb(0.392, 0.584, 0.929));

        self.complex.draw(ctx, Vec2::new(256.0, 64.0));
        Ok(())
    }
}

fn main() -> tetra::Result {
    ContextBuilder::new("CHANGE_ME", 600, 360)
        .quit_on_escape(true)
        .build()?
        .run(Game::new)
}
