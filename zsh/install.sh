SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
source "${SCRIPT_DIR}/../utils.sh"

function _setup_zshrc() {
    SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

    echo "[*] setup .zshrc"
    if [ -f ~/.zshrc ]; then
        ask_yes_or_no "~/.zshrc already exists. Overwrite?"
        if [ $? = 0 ]; then
            rm -f ~/.zshrc
        else
            echo -e $'[x] setup .zshrc: \e[31mCancelled\e[m'
        fi
    fi
    cp "$SCRIPT_DIR/.zshrc" ~/.zshrc
}

function setup_zsh()
{
    case "$1" in
        "all" )
            _setup_zshrc
            ;;
        "zshrc" )
            _setup_zshrc
            ;;
    esac
}
