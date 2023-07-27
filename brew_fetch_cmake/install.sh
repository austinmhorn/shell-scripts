#!/bin/bash

source decorations.sh

# Check for bash
if [ -v "${BASH_VERSION:-}" ]
then
    echo $Red">>"$Reset" Bash is required to interpret this script."
else
    echo $Yellow">>"$Reset" Found bash"
    which bash
fi

ring_bell() {
  # Use the shell's audible bell.
  if [[ -t 1 ]]
  then
    printf "\a"
  fi
}

# Determine OS
OS="$OSTYPE"

# Determine Architecture
ARCH=$(uname -m)

# OS Specific Operations
echo $Yellow">>"$Reset" Detecting Operating System"
case "$OS" in
  darwin*)
    echo "OSX"
    if [[ ! $(command which -s xcode-select) == 0 ]]; then
      echo "** Detecting Xcode Command Line Tools - done"
      which xcode-select
    else
      echo "** Installing Xcode Command Line Tools"
      xcode-select --install
    fi ;;
  linux*)
    echo "Linux"
    if [[ ! $(command which -s xcode-select) == 0 ]]; then
      echo "** Detecting Xcode Command Line Tools - done"
      which xcode-select
    else
      echo "** Installing Xcode Command Line Tools"
      xcode-select --install
    fi
    ;;
  bsd*)
    echo "FreeBSD" ;;
  solaris*)
    echo "Solaris" ;;
  msys*)
    echo "Windows Bash/msysGit" ;;
  cygwin*)
    echo "Windows Cygwin" ;;
  *)
    echo -e "${RED}ERROR:${WHITE}"
    echo "Unknown OS: $OSTYPE"
    echo "Software is not compatible with architecture"
    exit 1 ;;
esac

# Determine architecture
if [[ "$ARCH" == x86_64* ]]; then
    echo "X64"
elif [[ "$ARCH" == i*86 ]]; then
    echo "X32"
elif  [[ "$ARCH" == arm* ]]; then
    echo "ARM"
fi

# Check for Homebrew
echo "Detecting Homebrew"
if [[ $(command -v brew) == "" ]]; then
    echo $Yellow">>"$Reset" Installing Homebrew"
    ring_bell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo $Yellow">>"$Reset" Found brew"
    which brew
fi
echo $Yellow">>"$Reset" Detecting Hoembrew - done"

# Check for cmake
echo $Yellow">>"$Reset" Detecting cmake"
if [[ $(command -v cmake) == "" ]]; then
    echo $Yellow">>"$Reset" Installing cmake"
    ring_bell
    brew install cmake
else
    echo $Yellow">>"$Reset" Found cmake"
    which cmake
fi
echo $Yellow">>"$Reset" Detecting cmake - done"
