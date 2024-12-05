#include "State/PlayState.hpp"
#include "State/PauseState.hpp"
#include "State/Base/StateMachine.hpp"
#include "Core/Resources.hpp"

#include <iostream>
#include <memory>

PlayState::PlayState(StateMachine& machine, sf::RenderWindow& window, Resources& resources, const bool replace)
    : State{ machine, window, resources, replace }
{
    const auto window_size = sf::Vector2f{ window.getSize() };

    m_background.setFillColor(sf::Color::Black);
    m_background.setSize(window_size);
}

void PlayState::pause()
{
    //std::cout << "PlayState Pause" << std::endl;;
}

void PlayState::resume()
{
    //std::cout << "PlayState Resume" << std::endl;;
}

void PlayState::handleEvent()
{
    for (auto event = sf::Event{}; m_window.pollEvent(event);)
    {        
        switch (event.type)
        {
            case sf::Event::Closed:
                m_machine.quit();
                break;
                
            case sf::Event::MouseMoved:
                ///< Get new mouse position
                m_current_mouse_position = m_window.mapPixelToCoords({ event.mouseMove.x, event.mouseMove.y });            
                break;
                
            case sf::Event::MouseButtonPressed:
                ///< Get location for mouse button press event
                m_current_mouse_position = m_window.mapPixelToCoords({ event.mouseButton.x, event.mouseButton.y });
                break;
                
            case sf::Event::MouseButtonReleased:
                ///< Get location for mouse button release event
                m_current_mouse_position = m_window.mapPixelToCoords({ event.mouseButton.x, event.mouseButton.y });
                break;
                
            case sf::Event::KeyPressed:
                if (event.key.code == sf::Keyboard::Key::Escape) 
                    m_next = StateMachine::build<PauseState>(m_machine, m_window, m_resources, false); // Move to PauseState
                break;
                
            case sf::Event::KeyReleased:
                break;

            case sf::Event::TextEntered:
                break;
                
            default:
                break;
        }
    }
}

void PlayState::update()
{
    static const auto clock = sf::Clock{};
    static auto last_frame_time = sf::Time{};
    const auto delta_time = clock.getElapsedTime() - last_frame_time;
    last_frame_time = clock.getElapsedTime();
    
    handleEvent();
}

void PlayState::draw()
{
    m_window.clear();
    
    m_window.draw(m_background);

    m_window.display();
}
