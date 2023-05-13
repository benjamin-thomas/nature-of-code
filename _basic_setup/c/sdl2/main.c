#include <stdio.h>
#include <SDL2/SDL.h>
#include <stdlib.h>

#define SCREEN_WIDTH 600
#define SCREEN_HEIGHT 400

#define fatal(fn) do { \
    fprintf(stderr, "%s error: %s\n", #fn, SDL_GetError()); \
    goto Quit; \
} while (0)

typedef struct Position {
    int x;
    int y;
} Position;

int main() {
    int exitCode = EXIT_FAILURE;
    SDL_Window *window = NULL;
    SDL_Renderer *renderer = NULL;
    SDL_Color bgColor = {255, 127, 40, 255};
    SDL_Color rectColor = {255, 0, 0, 255};
    Position pos = {0, 10};


    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) != 0)
        fatal(SDL_Init);

    window = SDL_CreateWindow("SDL2 Project",
                              SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                              SCREEN_WIDTH, SCREEN_HEIGHT,
                              SDL_WINDOW_SHOWN);

    if (window == NULL)
        fatal(SDL_CreateWindow);

    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if (renderer == NULL)
        fatal(SDL_CreateRenderer);

    SDL_Event evt;
    SDL_bool quit = SDL_FALSE;

    while (!quit) {
        while (SDL_PollEvent(&evt) != 0) {
            if (evt.type == SDL_QUIT) quit = SDL_TRUE;
        }

        pos.x += 2;
        pos.y += 1;

        if (SDL_SetRenderDrawColor(renderer, bgColor.r, bgColor.g, bgColor.b, bgColor.a) != 0)
            fatal(SDL_SetRenderDrawColor);

        if (SDL_RenderClear(renderer) != 0)
            fatal(SDL_RenderClear);

        if (SDL_SetRenderDrawColor(renderer, rectColor.r, rectColor.g, rectColor.b, rectColor.a) != 0) {
            fatal(SDL_SetRenderDrawColor);
        }

        SDL_Rect rect = {pos.x, pos.y, 70, 70};
        if (SDL_RenderFillRect(renderer, &rect) != 0)
            fatal(SDL_RenderFillRect);

        SDL_RenderPresent(renderer);

        // I'm not too sure how to handle FPS properly with SDL. This will do for now.
        SDL_Delay(16);
    }
    exitCode = EXIT_SUCCESS;

    Quit:
    if (renderer != NULL) SDL_DestroyRenderer(renderer);
    if (window != NULL) SDL_DestroyWindow(window);
    SDL_Quit();
    return exitCode;
}
