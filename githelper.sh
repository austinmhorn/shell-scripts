#!/usr/bin/env zsh

Reset="\033[0m"        # Text Reset
Bold="\033[1m"         # Bold
Italic="\033[3m"       # Italic
Red="\033[31m"         # Red
Green="\033[32m"       # Green
Yellow="\033[33m"      # Yellow

GIT_URL_PREFIX="https://github.com/"
GIT_URL_SUFFIX=".git"

GIT_USER_NAME=""
GIT_USER_EMAIL=""
GIT_DEFAULT_BRANCH=""

function fetchUserName() {
  GIT_USER_NAME=$(git config user.name)
}

function fetchUserEmail() {
  GIT_USER_EMAIL=$(git config user.email)
}

function fetchDefaultBranch() {
  GIT_DEFAULT_BRANCH=$(git config init.defaultBranch)
}

function fetchGlobalConfigData() {
  fetchUserName
  fetchUserEmail
  fetchDefaultBranch
}

function githelper() {
    while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
      -config | --config )
          echo "-- Configuring ${Bold}${Italic}${Green}githelper${Reset}"

          fetchGlobalConfigData
          
          # Check if either string is empty and return error if so
          if [[ -z "${GIT_USER_NAME}" ]]; then
            echo "${Bold}${Red}error${Reset}:"
            echo "*** GitHub ${Bold}Username${Reset} is not configured correctly in ${Italic}~/.gitconfig${Reset} ***"
            return 1
          elif [[ -z "${GIT_USER_EMAIL}" ]]; then
            echo "*** GitHub ${Bold}Email${Reset} is not configured correctly in ${Italic}~/.gitconfig${Reset} ***"
            return 1
          elif [[ -z "${GIT_DEFAULT_BRANCH}" ]]; then
            echo "*** GitHub ${Bold}Default Branch${Reset} is not configured correctly in ${Italic}~/.gitconfig${Reset} ***"
            return 1
          fi
          
          # Print configured git info
          echo "-- Git Username:   $GIT_USER_NAME"
          echo "-- Git Email:      $GIT_USER_EMAIL"
          echo "-- Default Branch: $GIT_DEFAULT_BRANCH"
          
          ;;
      -v | --version )
          echo "githelper 1.0.0"
          ;;
      esac; shift; done
      if [[ "$1" == '--' ]]; then shift; fi
}

function gitclone() {
  repo="${1}"
  
  if [[ -z "${repo}" ]]; then
    echo "${Bold}${Red}error${Reset}: '${Italic}$0${Reset}'"
    echo "*** Requires repository name as first arguement ***"
    return;
  else
    echo "-- Cloning GitHub repository '${Bold}${repo}${Reset}'"
  fi

  # Verify global variables contain data
  if [[ -z "${GIT_USER_NAME}" || -z "${GIT_USER_EMAIL}" || -z "${GIT_DEFAULT_BRANCH}" ]]; then
    githelper --config
  fi
  
  # Construct GitHub repo URL
  url="${GIT_URL_PREFIX}${GIT_USER_NAME}/${repo}${GIT_URL_SUFFIX}"
  branch="${GIT_DEFAULT_BRANCH}"
  
  # Parse flags
  while [[ "$2" =~ ^- && ! "$2" == "--" ]]; do case $2 in
    -b | --branch )
        echo "-- Cloning specified branch '${3}'"
        branch="${3}"
      ;;
  esac; shift; done;
  if [[ "$2" == '--' ]]; then shift; fi
  
  # Set command string
  cmd="git clone --branch ${branch} --single-branch $url"
  
  # Run clone command
  eval "$cmd"
  
  if [[ -e "${repo}" && -d "${repo}" ]]; then
    echo "-- Process succeeded"
  fi
}
