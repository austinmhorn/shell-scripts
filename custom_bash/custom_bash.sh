#!/bin/bash

# Draw banner around single line of characters
function banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

# Box a string
function box()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 7
  echo "**${b//?/*}**
* ${b//?/ } *"
  for l in "${s[@]}"; do
    printf '* %s%*s%s *\n' "$(tput setaf 7)" "-$w" "$l" "$(tput setaf 7)"
  done
  echo "* ${b//?/ } *
**${b//?/*}**"
  tput sgr 0
}

# Absolute directory
function path() {
  prev_path="$1"
  # Resolve the symlink(s) recursively
  while true; do
    abs_path=`readlink "$prev_path"`
    if [ -z "$abs_path" ]; then
      abs_path="$prev_path"
      break
    else
      prev_path="$abs_path"
    fi
  done
  unset prev_path

  # Get the absolute directory of the final $abs_path
  orig_dir=`pwd`
  cd `dirname "$abs_path"`
  # prints an absolute path here
  pwd
  cd "$orig_dir"
  unset abs_path orig_dir
}

# Duplicate directory recursively
function dupedir() {
  src_dir="$1"
  dest_dir="$1_copy"
  echo "Creating backup of $src_dir"
  mkdir -p "$dest_dir"
  cp -R "$src_dir" "$dest_dir"
}
