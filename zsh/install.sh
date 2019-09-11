SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
source "${SCRIPT_DIR}/../utils.sh"

function _setup_zshrc() {
    SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

    echo "[*] setup .zshrc"
    copy_file_safe .zshrc ~/.zshrc

    echo "[*] setup .local.zshrc"
    copy_file_safe .local.zshrc ~/.local.zshrc
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
