DIR=bak
FILES=".bashrc .vimrc .gitconfig .pystartup"
 
# Hack to allow dry runs
COM=
mv () { $COM command mv $@ 2>/dev/null ; }
ln () { $COM command ln $@; }
rm () { $COM command rm $@ 2>/dev/null ; }

set -e
# trap put dotfiles back
#trap "echo a"

install () {
    # mv old dotfiles to backup location
    mkdir -p $DIR
    echo Installing $FILES
    for f in $FILES;
    do
        mv ~/$f $DIR ;
        ln -s $PWD/$f ~/$f ;
    done
}

uninstall () {
    echo Uninstalling $FILES
    for f in $FILES ;
    do
        if [ "$1" = "-f" ] ;
        then
            # rm dotfiles if complete uninstall
            rm ~/$f ;
        fi
        # mv old dotfiles back
        mv $DIR/$f ~/$f ;
    done
}

main () {
    UNINSTALL=
    FORCE=
    # Parse arguments
    while test $# -gt 0
    do
        case "$1" in
            -u|--uninstal|uninstall)
                UNINSTALL=1;
                ;;
            -f|--force)
                FORCE=1;
                ;;
            -d|--dry|--dry-run)
                COM="echo"
                ;;
            -h|--help)
                echo "Setup dotfiles"
                echo "  -u, --uninstall, uninstall   Uninstall the dotfiles"
                echo "  -f, --force                  Force remove all the dotfiles before coping back old version"
                echo "  -d, --dry, --dry-run         Only echo the commands that would have run"
                exit
                ;;
        esac
        shift
    done

    if [ "$UNINSTALL" = 1 ] ;
    then
        uninstall $FORCE
    else
        install
    fi
}


main $@
