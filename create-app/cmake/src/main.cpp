#include "Core/Application.hpp"

int main(int arc, const char **argv) 
{
    auto app = Application{};
    app.run();

    return 0;
}