#include <SFML/Graphics.hpp>

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

void draw(sf::RenderWindow &window, sf::CircleShape &circle) {
    window.clear(sf::Color::Black);

    window.draw(circle);
    window.display();
}

void update(sf::CircleShape &circle) {
    auto pos = circle.getPosition();
    pos.x += 2.f;
    circle.setPosition(pos.x, pos.y);
}

void update2(sf::CircleShape *circle) {
    auto pos = circle->getPosition();
    pos.y += 1.f;
    circle->setPosition(pos.x, pos.y);
}

int main() {
    auto window = sf::RenderWindow{{640u, 360u}, "SFML: CHANGE_ME"};
    window.setFramerateLimit(60);

    sf::CircleShape circle = sf::CircleShape(50.f);
    circle.setPosition(100, 100);
    circle.setFillColor(sf::Color(255, 0, 0));
    circle.setOutlineColor(sf::Color::Green);
    circle.setOutlineThickness(2.0f);

    while (window.isOpen()) {
        handleClose(window);
        update(circle); // the receiver decides to receive a reference
        update2(&circle); // the caller decides to send a reference
        draw(window, circle);
    }
}