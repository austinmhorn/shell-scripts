#include <cassert> 

#include "Core/Application.hpp"

void Application::run()
{
    m_window.create({sf::VideoMode(800, 600)}, "Title", sf::Style::Default);

    m_window.setFramerateLimit( 120 );
        
    loadResources();

    m_machine.init( StateMachine::build<HomeState>(m_machine, m_window, m_resources, true) );    

    // Main loop
    while (m_machine.running())
    {
        m_machine.nextState();
        m_machine.update();
        m_machine.draw();
    }
}

void Application::loadResources()
{

}
