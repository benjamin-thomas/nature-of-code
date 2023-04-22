import * as os from "os";
import * as fs from "fs";

type Dimension = {
    readonly width: number,
    readonly height: number,
}

type Color = {
    readonly r: number,
    readonly g: number,
    readonly b: number,
}

function genNoise(dim: Dimension, colors: Color[], filepath: string) {
    const maxValue = 0xFF;
    const magicNumber = `P6`;

    const stream = fs.createWriteStream(filepath);
    stream.write(`${magicNumber}${os.EOL}`);
    stream.write(`${dim.width} ${dim.height}${os.EOL}`);
    stream.write(`${maxValue}${os.EOL}`);

    for (let x = 0; x < dim.width; x++) {
        for (let y = 0; y < dim.height; y++) {
            const randIdx = Math.floor(Math.random() * colors.length);
            const col = colors[randIdx];
            const rgb = [
                Math.floor(col.r * maxValue),
                Math.floor(col.g * maxValue),
                Math.floor(col.b * maxValue),
            ];
            stream.write(Buffer.from(rgb));
        }
    }
}

function run(): void {
    const dim: Dimension = {width: 512, height: 512};
    const colors: Color[] = [
        {r: 0.4078, g: 0.4078, b: 0.3764}, // [103, 103,  95] / [0x67, 0x67, 0x5F]
        {r: 0.7606, g: 0.6274, b: 0.6313}, // [193, 159, 160] / [0xC1, 0x9F, 0xA0]
        {r: 0.8980, g: 0.9372, b: 0.9725}, // [228, 238, 247] / [0xE4, 0xEE, 0xF7]
    ];
    const filepath = '/tmp/ts-white-noise.ppm';
    genNoise(dim, colors, filepath);

    console.log(`Pattern generated at: ${filepath}`);
}

run();
