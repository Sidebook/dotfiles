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
