use std::ffi::c_uint;
use raylib::prelude::*;


fn main() {
    unsafe { ffi::SetConfigFlags(ConfigFlags::FLAG_MSAA_4X_HINT as c_uint) }

    let (mut rl, thread) = init()
        .size(800, 450)
        .title("Rust/Raylib: CHANGE_ME")
        .build();

    rl.set_target_fps(60);

    let mut x = 0;
    let mut y = 0;
    while !rl.window_should_close() {
        let mut d = rl.begin_drawing(&thread);

        d.clear_background(Color::BLACK);
        update(&mut x, &mut y);
        d.draw_circle(x, y, 25.0, Color::RED);
    }
}

fn update(x: &mut i32, y: &mut i32) {
    *x += 1;
    if *x % 2 == 0 {
        *y += 1;
    }
}

