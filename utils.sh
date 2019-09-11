function ask_yes_or_no() {
    while true; do
        PREF=$'\e[96m'
        SUF=$'\e[0m [y/n]'
        PROMPT="$PREF$1$SUF"
        read -p "$PROMPT" yn
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

function copy_file_safe()
{
    echo "Copy $SCRIPT_DIR/$1 ---> $2"
    ABORT=0
    if [ -f $2 ]; then
        ask_yes_or_no "$2 already exists. Overwrite?"
        ABORT=$?
    fi
    if [ $ABORT = 0 ]; then
        rm -f $2
        cp -i "$SCRIPT_DIR/$1" $2
    else
        echo -e $'\e[31mCopy cancelled\e[m'
    fi
    return $COPY
}
