const std = @import("std");

// zig run src/main.zig

// Zig is slower than C.
// I'm not sure how to create a release build, but it doesn't look like it would change things much.
//
// $ time ./zig-out/bin/zig
// info: Generated file: /tmp/zig-white-noise.ppm

// real    0m0.058s
// user    0m0.057s
// sys     0m0.000s

var rnd = std.rand.DefaultPrng.init(0);

const Color = struct {
    r: f32,
    g: f32,
    b: f32,
};

const Dim = struct {
    width: u16,
    height: u16,
};

fn gen_ppm(dim: Dim, colors: [3]Color, scale: u16, filepath: []const u8) !void {
    const file = try std.fs.cwd().createFile(filepath, .{});
    defer file.close();

    var bw = std.io.bufferedWriter(file.writer());

    _ = try bw.write("P6\n");

    const allocator = std.heap.page_allocator;

    _ = try allocator.alloc(u8, 100);

    var str = try std.fmt.allocPrint(
        allocator,
        "{d} {d}\n",
        .{ dim.width, dim.height },
    );
    defer allocator.free(str);
    _ = try bw.write(str);

    str = try std.fmt.allocPrint(
        allocator,
        "{d}\n",
        .{scale},
    );
    _ = try bw.write(str);

    for (0..dim.width) |_| {
        for (0..dim.height) |_| {
            const rand_idx = rnd.random().intRangeAtMost(usize, 0, colors.len - 1);
            const col: Color = colors[rand_idx];
            const scaleF: f32 = @intToFloat(f32, scale);

            const r_scaled: u8 = @floatToInt(u8, (col.r * scaleF));
            const g_scaled: u8 = @floatToInt(u8, (col.g * scaleF));
            const b_scaled: u8 = @floatToInt(u8, (col.b * scaleF));

            const data = [_]u8{ r_scaled, g_scaled, b_scaled };
            _ = try bw.write(&data);
        }
    }

    try bw.flush();
}

pub fn main() !void {
    const cols = [_]Color{
        Color{ .r = 0.4078, .g = 0.4078, .b = 0.3764 },
        Color{ .r = 0.7606, .g = 0.6274, .b = 0.6313 },
        Color{ .r = 0.8980, .g = 0.9372, .b = 0.9725 },
    };

    const dim = Dim{ .width = 512, .height = 512 };
    const filepath = "/tmp/zig-white-noise.ppm";
    try gen_ppm(dim, cols, 255, filepath);
    std.log.info("Generated file: {s}", .{filepath});
}
