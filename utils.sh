function ask_yes_or_no() {
    while true; do
        read -p "$1 [y/n]" yn
        case $yn in
            [Yy]* ) return 0 ;;
            [Nn]* ) return 1 ;;
            * ) echo "Please answer Y/y or N/n";;
        esac
    done
}

function make_directory()
{
    if [ ! -d $1 ]; then
        mkdir -p $1
    fi
}

function check_exists_directory()
{
    if [ ! -d $1 ]; then
        return 1
    else
        return 0
    fi
}
