package main

import (
	"github.com/veandco/go-sdl2/sdl"
)

var (
	ScreenHeight int32 = 400
	ScreenWidth  int32 = 600
)

func panicIf(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	panicIf(sdl.Init(sdl.INIT_AUDIO | sdl.INIT_VIDEO))

	// Window
	window, createWindowErr := sdl.CreateWindow("Go/SDL2: CHANGE_ME",
		sdl.WINDOWPOS_CENTERED, sdl.WINDOWPOS_CENTERED,
		ScreenWidth, ScreenHeight,
		sdl.WINDOW_SHOWN)
	panicIf(createWindowErr)
	defer func(window *sdl.Window) {
		panicIf(window.Destroy())
	}(window)

	// Renderer
	renderer, createRendererErr := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)
	panicIf(createRendererErr)
	defer func(renderer *sdl.Renderer) {
		panicIf(renderer.Destroy())
	}(renderer)

	// Loop vars
	bgColor := sdl.Color{R: 255, G: 127, B: 40, A: 255}
	rectColor := sdl.Color{R: 255, G: 0, B: 0, A: 255}
	rect := sdl.Rect{X: 0, Y: 0, W: 70, H: 70}
	quit := false

	// Loop
	for !quit {
		// Update vars
		rect.X += 2
		rect.Y += 1

		// Poll
		for sdl.PollEvent() != nil {
			evt := sdl.PollEvent()
			switch evt.(type) {
			case *sdl.QuitEvent:
				println("Quitting...")
				quit = true
				break
			}
		}

		// Draw
		panicIf(
			renderer.SetDrawColor(bgColor.R, bgColor.G, bgColor.B, bgColor.A),
		)
		panicIf(
			renderer.Clear(),
		)
		panicIf(
			renderer.SetDrawColor(rectColor.R, rectColor.G, rectColor.B, rectColor.A),
		)
		panicIf(
			renderer.FillRect(&rect),
		)
		renderer.Present()

		sdl.Delay(16)
	}

}
