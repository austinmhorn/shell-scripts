#!/bin/bash

# Configure and generate build files
function genbuild()
{
    cmake -S . -B build
}

# Build CMake project
function build()
{
    genbuild
    cmake --build build
}

# Build project for Xcode IDE
function xbuild()
{
    cmake -S . -B build -G Xcode
    (cd xbuild; xcodebuild build)
}

# Target clean
function clean()
{
    cmake --build build --target clean
}

# Full clean
function fclean()
{
    if [[ -d "build" ]]; then
        rm -R build
    fi
    if [[ -d "xbuild" ]]; then
        rm -R bin
    fi
    if [[ -d "bin" ]]; then
        rm -R bin
    fi
}
