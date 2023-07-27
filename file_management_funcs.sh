#!/usr/bin/bash

source decorations.sh

WARNING="            WARNING             "

function warning()
{
    echo "$BYellow"
    banner "$WARNING"
    echo "$Reset""-- This action cannot be reversed --"'\n'
}

function confirm()
{
    echo "Do you want to proceed? (YES/NO): "
    read -r response
    if [ "$response" = YES ]; then
        return 0
    elif [ "$response" = NO ]; then
        return 1
    else
        echo -n "Invalid response - "
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
}

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

function findbyext()
{
    echo -n "$BGreen"
    find . -name "*.$1" -type f
    echo -n "$Reset"
}

function findbyname()
{
    echo -n "$BGreen"
    find . -name "$1.*" -type f
    echo -n "$Reset"
}

function delbyext()
{
    if [[ -z "$1" ]]; then
        # String is empty
        echo -e "delall: missing arguement: extension of files to delete"
        return -1
    elif [[ -n "$1" ]]; then
        # String is not empty
        findbyext "$1"
        
        warning
        
        if confirm; then
            echo "Deleting files..."
            find . -name "*.$1" -type f -delete
        else
            echo "Process aborted"
        fi
    fi
}

function delbyname()
{
    if [[ -z "$1" ]]; then
        # String is empty
        echo -e "delall: missing arguement: name of files to delete"
        return -1
    elif [[ -n "$1" ]]; then
        # String is not empty
        findbyname "$1"
        
        warning
        
        if confirm; then
            echo "Deleting files..."
            find . -name "$1.*" -type f -delete
        else
            echo "Process aborted"
        fi
    fi
}

function delall()
{
    while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
    -e | --extension )
        shift;
        delbyext "$1"
        ;;
    -n | --name )
        shift;
        delbyname "$1"
        ;;
    esac; shift; done
    if [[ "$1" == '--' ]]; then shift; fi
}

function exists()
{
    if [[ -e "$1" || -d "$1" || -f "$1" || -x "$1" ]]; then
        return 0
    else
        return 1
    fi
}

function copydir()
{
    src_dir="$1"
    declare -i n=1
    dest_dir="$1_$n"
    
    while exists "$dest_dir"; do
        ((n=n+1))
        dest_dir="$src_dir""_$n"
    done
    
    mkdir "$dest_dir"
    cp -R "$src_dir/" "$dest_dir"
}

function copyfile()
{
    src_file=$(basename -- "$filename")
    name="${src_file%%.*}"
    ext=$([[ "$filename" = *.* ]] && echo ".${filename##*.}" || echo '')
    declare -i n=1
    dest_file="$name""_$n""$ext"
    
    while exists "$dest_file"; do
        ((n=n+1))
        dest_file="$name""_$n""$ext"
    done
    
    cp "$src_file" "$dest_file"
}

function copy()
{
    if [[ -d "$1" ]]; then
        copydir "$1"
    elif [[ -f "$1" ]]; then
        copyfile "$1"
    else
        # unfinished
    fi
}
