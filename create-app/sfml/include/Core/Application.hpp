#ifndef Application_hpp
#define Application_hpp

#include <SFML/Graphics/RenderWindow.hpp>

#include "../State/Base/StateMachine.hpp"
#include "Resources.hpp"
#include "SystemInfo.hpp"
#include "State/HomeState.hpp"

class Application
{
public:

    virtual void run();
    
protected:
    
    virtual void loadResources();

private:

    StateMachine     m_machine;
    sf::RenderWindow m_window;
    Resources        m_resources;
};

#endif /* Application_hpp */