#!/bin/bash

BASEDIR=`dirname $0`
BASEDIR=`(cd "$BASEDIR"; pwd)`

source "${BASEDIR}/zsh/install.sh"

function show_help()
{
    echo 'Available arguments'
    echo ' - all         : invoke the following commands'
    echo ' - zsh         : setup zsh settings'
    echo ' - help        : show this help'
}

function process()
{
    case "$1" in 
        "zsh" )
            setup_zsh "all"
            return 0
            ;;
        "all" )
            setup_zsh "all"
            return 0
            ;;
        *)
            echo "option: ${1} not found."
            show_help
            return 1
            ;;
    esac
}

if [ $# -ge 1 ]; then
    for mode in "$@"
    do
        process "${mode}"
    done
else
    show_help
fi
