BAK_DIR=bak
#                skip dir    skip non-dot    skip vim .swp files
FILES=$(ls -ap | grep -v / | grep -E '^\.' | grep -v -E '\..*\..*\..*')
 
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
    DIR=$BAK_DIR/$(date +%s)
    mkdir -p $DIR
    echo Installing $FILES
    for f in $FILES;
    do
        if [ -e ~/$f ]; then
            mv ~/$f $DIR ;
        fi
        ln -s $PWD/$f ~/$f ;
    done

    echo 'You also should run:'
    echo '    ln -s bin/ ~/bin'
    echo '    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
    echo '    vim +PluginInstall +qall'
}

uninstall () {
    echo Uninstalling $FILES
    DIR=$(ls $BAK_DIR | sort -nr | head -n 1)
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
    echo "You also should unlink '~/bin' and remove ~/.vim/bundle/"
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
