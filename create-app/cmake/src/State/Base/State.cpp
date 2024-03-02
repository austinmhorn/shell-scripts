#include "State/Base/State.hpp"

State::State(StateMachine& machine, sf::RenderWindow &window, Resources& resources, const bool replace)
    : m_machine(machine)
    , m_window(window)
    , m_resources(resources)
    , m_replace(replace)
{
    
}

std::unique_ptr<State> State::next()
{
    return std::move(m_next);
}

bool State::replace() const
{
    return m_replace;
}
