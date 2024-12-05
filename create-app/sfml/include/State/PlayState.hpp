#ifndef PlayState_hpp
#define PlayState_hpp

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Window/Event.hpp>
#include <SFML/Graphics/Color.hpp>
#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/Graphics/Text.hpp>

#include "Base/State.hpp"

class PlayState final : public State
{
public:
    PlayState(StateMachine& machine, sf::RenderWindow& window, Resources& resources, const bool replace = true);

    void pause() override;
    void resume() override;
    void handleEvent() override;
    void update() override;
    void draw() override;
    
private:

    sf::RectangleShape m_background;
    sf::Vector2f       m_current_mouse_position;
};

#endif /* PlayState_hpp */