#!/usr/bin/env zsh

# create-app -cmake <project_name>
function create-app() {
    while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
      -cmake )
          echo "-- Configuring CMake app template"
          
          project_name="${2}"
          
          mkdir cmake
          mkdir -p cmake/Modules
          mkdir -p cmake/templates
          mkdir docs
          mkdir include
          mkdir -p include/Core
          mkdir -p include/State
          mkdir resources
          mkdir -p resources/fonts
          mkdir src
          mkdir -p src/Core
          mkdir -p src/State

          sedargs="s/REPLACE_WITH_PROJECT_NAME/${project_name}/"
          sed ${sedargs} ~/create-app/cmake/CMakeLists.txt >> $(pwd)/CMakeLists.txt
          
          cp ~/create-app/cmake/src/main.cpp $(pwd)/src/main.cpp
          cp -R ~/create-app/cmake/include/Core/ $(pwd)/include/Core/
          cp ~/create-app/cmake/include/Config.hpp $(pwd)/include/
          cp -R ~/create-app/cmake/include/State/ $(pwd)/include/State/
          cp -R ~/create-app/cmake/resources/fonts/ $(pwd)/resources/fonts/
          cp -R ~/create-app/cmake/src/Core/ $(pwd)/src/Core/
          cp -R ~/create-app/cmake/src/State/ $(pwd)/src/State/

          touch $(pwd)/docs/README.md
          
          echo "-- Succesfully create CMake project template named '$project_name'"
          ;;
      -cpp | -c++ | -cxx )
          echo "-- Configuring C++ app template"

          project_name="${2}"

          mkdir src
          
          cp ~/create-app/cpp/src/main.cpp $(pwd)/src/main.cpp

          echo "-- Succesfully create C++ project template named '$project_name'"

          ;;
      esac; shift; done
      if [[ "$1" == '--' ]]; then shift; fi
}
