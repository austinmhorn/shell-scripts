#!/usr/bin/env zsh

# create-app -cmake <project_name>
function create-app() {
    while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
      -sfml | -SFML )
          echo "-- Configuring SFML app template"
          
          project_name="${2}"
          project_bootstrap_dir="sfml"
          
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
          sed ${sedargs} ~/create-app/${project_bootstrap_dir}/CMakeLists.txt >> $(pwd)/CMakeLists.txt
          
          cp ~/create-app/${project_bootstrap_dir}/src/main.cpp $(pwd)/src/main.cpp
          cp -R ~/create-app/${project_bootstrap_dir}/include/Core/ $(pwd)/include/Core/
          cp ~/create-app/${project_bootstrap_dir}/include/Config.hpp $(pwd)/include/
          cp -R ~/create-app/${project_bootstrap_dir}/include/State/ $(pwd)/include/State/
          cp -R ~/create-app/${project_bootstrap_dir}/resources/fonts/ $(pwd)/resources/fonts/
          cp -R ~/create-app/${project_bootstrap_dir}/src/Core/ $(pwd)/src/Core/
          cp -R ~/create-app/${project_bootstrap_dir}/src/State/ $(pwd)/src/State/

          touch $(pwd)/docs/README.md
          
          echo "-- Succesfully created CMake project template named '$project_name'"
          ;;
      -cmake | -CMake | -CMAKE )
          echo "-- Configuring CMake app template"
          
          project_name="${2}"
          project_bootstrap_dir="cmake"
          
          mkdir include
          mkdir src

          sedargs="s/REPLACE_WITH_PROJECT_NAME/${project_name}/"
          sed ${sedargs} ~/create-app/${project_bootstrap_dir}/CMakeLists.txt >> $(pwd)/CMakeLists.txt
          
          cp ~/create-app/${project_bootstrap_dir}/src/main.cpp $(pwd)/src/main.cpp
          cp ~/create-app/${project_bootstrap_dir}/include/main.hpp $(pwd)/include/main.hpp
          
          echo "-- Succesfully created CMake project template named '$project_name'"
          ;;
      -cpp | -c++ | -cxx )
          echo "-- Configuring C++ app template"

          project_name="${2}"
          project_bootstrap_dir="cpp"

          mkdir src
          
          cp ~/create-app/${project_bootstrap_dir}/src/main.cpp $(pwd)/src/main.cpp

          echo "-- Succesfully created C++ project template named '$project_name'"

          ;;
      esac; shift; done
      if [[ "$1" == '--' ]]; then shift; fi
}
