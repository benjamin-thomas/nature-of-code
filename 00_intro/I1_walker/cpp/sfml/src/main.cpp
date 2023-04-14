
#include <SFML/Graphics.hpp>
#include <random>

const uint SCREEN_WIDTH = 640u;
const uint SCREEN_HEIGHT = 360u;

std::mt19937 gen(std::random_device{}());

int randInt(int minVal, int maxVal) {
    std::uniform_int_distribution<> dist(minVal, maxVal);
    return dist(gen);
}

class Walker {
    float x, y;
    sf::RenderWindow *window;
    sf::RectangleShape rect;

public:
    explicit Walker(sf::RenderWindow *window) {
        this->window = window;
        x = SCREEN_WIDTH / 2.0f;
        y = SCREEN_HEIGHT / 2.0f;
        const sf::Vector2<float> &size = sf::Vector2f(1, 1);
        this->rect = sf::RectangleShape(size);
        this->rect.setPosition(x, y);
    }

    void step() {
        x += (float) randInt(-1, 1);
        y += (float) randInt(-1, 1);
        this->rect.setPosition(x, y);
    }

    void draw() {
        window->draw(rect);
    }

};


void handleClose(sf::RenderWindow &window) {
    for (auto event = sf::Event{}; window.pollEvent(event);) {
        switch (event.type) {
            case sf::Event::Closed:
                window.close();
                break;
            case sf::Event::KeyPressed:
                if (event.key.code == sf::Keyboard::Escape) {
                    window.close();
                }
                break;

            default:
                break;
        }
    }
}

int main() {
    auto window = sf::RenderWindow{{SCREEN_WIDTH, SCREEN_HEIGHT}, "SFML: Random Walker"};
    window.setFramerateLimit(60);
    auto *walker = new Walker(&window);

    while (window.isOpen()) {
        handleClose(window);

        walker->step();
        walker->draw();

        window.display();
    }
}