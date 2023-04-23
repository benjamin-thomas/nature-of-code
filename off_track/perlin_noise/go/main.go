/*

rm /tmp/go-white-noise.ppm ; go run main.go && eog /tmp/go-white-noise.ppm

---

go build -o dist/gen_noise

$ time ./dist/gen_noise

real    0m0.023s
user    0m0.016s
sys     0m0.004s

*/

package main

import (
	"bufio"
	"fmt"
	"io"
	"math/rand"
	"os"
)

type Dimension struct {
	width  uint
	height uint
}

type Color struct {
	r float32
	g float32
	b float32
}

func genNoise(dim Dimension, colors []Color, filename string) error {
	file, createErr := os.Create(filename)
	if createErr != nil {
		return createErr
	}
	bw := bufio.NewWriter(file)

	writeErr := writePpmData(dim, colors, bw)
	if writeErr != nil {
		return writeErr
	}
	return file.Close()
}

func writePpmData(dim Dimension, colors []Color, writer io.Writer) error {
	ppmMagicNumber := "P6"
	maxValue := 255

	_, writeErr1 := fmt.Fprintf(writer, "%s\n%d %d\n%d\n",
		ppmMagicNumber,
		dim.width,
		dim.height,
		maxValue)
	if writeErr1 != nil {
		return writeErr1
	}

	for x := uint(0); x < dim.width; x++ {
		for y := uint(0); y < dim.height; y++ {
			randIdx := rand.Intn(len(colors))
			color := colors[randIdx]

			r := color.r
			g := color.g
			b := color.b

			// Scale the RGB values to [0.0, 255.0). Then convert to byte values (0-255).
			r2 := byte(r * float32(maxValue))
			g2 := byte(g * float32(maxValue))
			b2 := byte(b * float32(maxValue))
			rgb := []byte{r2, g2, b2}
			_, writeErr2 := writer.Write(rgb)
			if writeErr2 != nil {
				return writeErr2
			}
		}
	}
	return nil
}

func main() {
	dim := Dimension{width: 512, height: 512}
	colors := []Color{
		{0.4078, 0.4078, 0.3764}, // [103, 103,  95] / [0x67, 0x67, 0x5F]
		{0.7606, 0.6274, 0.6313}, // [193, 159, 160] / [0xC1, 0x9F, 0xA0]
		{0.8980, 0.9372, 0.9725}, // [228, 238, 247] / [0xE4, 0xEE, 0xF7]
	}
	filename := "/tmp/go-white-noise.ppm"
	err := genNoise(dim, colors, filename)
	if err != nil {
		fmt.Printf("Could not generate noise: %s\n", err)
	} else {
		fmt.Printf("Noise generated at: %s\n", filename)
	}
}
