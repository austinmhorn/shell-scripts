#ifndef Assets_hpp
#define Assets_hpp

#include "Config.hpp"
#include "Core/Sansation.hpp"

#include <SFML/Graphics/Font.hpp>
#include <SFML/Graphics/Texture.hpp>
#include <SFML/Graphics/Color.hpp>

#include <iostream>
#include <string>
//#include <new>        // std::bad_alloc
//#include <cmath>      // std::ceil, std::log
//#include <cassert>    // assert

// Images
static const std::string __filepath_space_wars_logo = "assets/png/logo/space-wars-logo.png";

// Fonts
static const std::string __filepath_zorque = "resources/fonts/Zorque.otf";


namespace Fonts
{
    static const sf::Font load_font(const std::string& filepath)
    {
        static sf::Font font;
        try 
        {
            if ( !font.loadFromFile(filepath) )
                throw std::runtime_error("Failed loading font: ");
            else
            {
#if defined(APP_DEBUG)
                std::cout << "Loaded font: " << filepath << std::endl;
#endif 
            }
        }
        catch(const std::runtime_error &e) 
        {
            std::cerr << "std::runtime_error::what(): " << e.what() << filepath << std::endl;
        }
        return font;
    }

    static sf::Font __load_zorque() 
        { return load_font(__filepath_zorque); }
}


////////////////////////////////////////////////////////////
/// \namespace Textures
///
/// \brief
////////////////////////////////////////////////////////////
namespace Textures 
{
    static sf::Texture __load_texture(const std::string& filepath)
    {
        static sf::Texture texture;
        try 
        {
            if ( !texture.loadFromFile(filepath) )
                throw std::runtime_error("Failed loading texture: ");
            else
            {
#if defined(APP_DEBUG)
                std::cout << "Loaded image: " << filepath << std::endl;
#endif 
            }
        }
        catch(const std::runtime_error &e) 
        {
            std::cerr << "std::runtime_error::what(): " << e.what() << filepath << std::endl;
        }
        return texture;
    }

    static sf::Texture __load_space_wars_logo() 
        { return __load_texture(__filepath_space_wars_logo); }

} // MARK: End of namespace 'Textures'

struct Resources
{
    static const sf::Font Sansation;
    static const sf::Font Zorque;
    
    static const sf::Color Gray;
    static const sf::Color DarkGreen;
    static const sf::Color DarkRed;
    static const sf::Color DarkPurple;
    static const sf::Color LightBlue;
    static const sf::Color Seafoam;
    static const sf::Color LightGreen;
    static const sf::Color Peach;
    static const sf::Color Tan;
    static const sf::Color Pink;
    static const sf::Color LightPurple;
    static const sf::Color Orange;
    static const sf::Color DarkBlue;
};

#endif /* Assets_hpp */
