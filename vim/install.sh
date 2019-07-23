#!/bin/bash

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
source "${SCRIPT_DIR}/../utils.sh"

VIM_BUNDLE_DIRECTORY=~/.vim/bundle

function _setup_vim_basics()
{
    echo '[*] setup_vim basics'
    SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

    make_directory ${VIM_BUNDLE_DIRECTORY}

    if ! check_exists_directory "${VIM_BUNDLE_DIRECTORY}/neobundle.vim"; then
        echo ' -> Setting up neobundle.vim'
        git clone https://github.com/Shougo/neobundle.vim ${VIM_BUNDLE_DIRECTORY}/neobundle.vim
    else
        echo ' -> Already exists, Update'
        pushd "${VIM_BUNDLE_DIRECTORY}/neobundle.vim"
        git pull origin master
        popd
    fi

    if ! check_exists_directory "${VIM_BUNDLE_DIRECTORY}/vimproc"; then
        echo ' -> Setting up vimproc'
        git clone https://github.com/Shougo/vimproc ${VIM_BUNDLE_DIRECTORY}/vimproc
    else
        echo ' -> Already exists, Update'
        pushd "${VIM_BUNDLE_DIRECTORY}/vimproc"
        git pull origin master
        popd
    fi
    pushd ${VIM_BUNDLE_DIRECTORY}/vimproc; make; popd;
}

function _update_vimrc()
{
    echo '[*] setup_vim vimrc'
    SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
    echo ${SCRIPT_DIR}

    echo ' -> Updating vimrc'
    cp -r ${SCRIPT_DIR}/.vimrc ~/.
    echo ' -> Updating vim color scheme'
    cp -r ${SCRIPT_DIR}/colors ~/.vim/
    if check_exists_directory "${VIM_BUNDLE_DIRECTORY}/neobundle.vim"; then
        echo ' -> Automatically invoke :NeoBundleInstall'
        ${VIM_BUNDLE_DIRECTORY}/neobundle.vim/bin/neoinstall
    fi
}

function setup_vim()
{
    case "$1" in
        "all" )
            _setup_vim_basics
            _update_vimrc
            ;;
        "basics" )
            _setup_vim_basics
            ;;
        "vimrc" )
            _update_vimrc
            ;;
    esac
}
