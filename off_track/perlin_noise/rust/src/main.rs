/*
    NOTE: I get better performance than C, with minimal effort!

---

    $ time ./target/release/rust

    real    0m0.010s
    user    0m0.007s
    sys     0m0.004s

---

    $ time ./cmake-build-release/c

    real    0m0.029s
    user    0m0.024s
    sys     0m0.005s
*/
use std::fs::File;
use std::io::{BufWriter, Write};
use rand;
use rand::Rng;

struct Color {
    r: f32,
    g: f32,
    b: f32,
}

const PPM_MAGIC_NUMBER: &str = "P6";

fn main() {
    let filename = "/tmp/white-noise.ppm";

    generate_pattern(512, 512, 255, filename).expect("Could not generate pattern!");
    println!("Noise generated at: {}", filename);
}

fn generate_pattern(width: u16, height: u16, scale: u16, filename: &str) -> std::io::Result<()> {
    let mut rng = rand::thread_rng();
    let colors = [
        Color {
            r: 0.4078,
            g: 0.4078,
            b: 0.3764,
        },
        Color {
            r: 0.7606,
            g: 0.6274,
            b: 0.6313,
        },
        Color {
            r: 0.8780,
            g: 0.9372,
            b: 0.9725,
        },
    ];

    let file = File::create(filename)?;
    let mut bw = BufWriter::new(file);

    bw.write_fmt(format_args!(
        "{PPM_MAGIC_NUMBER}\n\
         {width} {height}\n\
         {scale}\n",
    ))?;

    for _x in 1..=width {
        for _y in 1..=height {
            let rand_idx = rng.gen_range(0..(colors.len()));
            let col = colors.get(rand_idx).unwrap();

            let r = col.r * scale as f32;
            let g = col.g * scale as f32;
            let b = col.b * scale as f32;

            bw.write(&[r as u8])?;
            bw.write(&[g as u8])?;
            bw.write(&[b as u8])?;
        }
    }

    Ok(())
}
