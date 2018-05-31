DIR=.bak/
FILES=".bashrc .vimrc .gitconfig .pystartup"

install () {
# mv old dotfiles to backup location
    mkdir -p $DIR
    for f in $FILES;
    do
        mv ~/$f $DIR ;
        ln -sf $f ~/$f ;
    done
}

uninstall () {
#what if they dont exist?
    for f in $FILES ;
    do
        if [ -n "$1" ] ;
        then
# rm dotfiles if complete uninstall
            rm ~/$f ;
        fi
# mv old dotfiles back
        mv $DIR/$f ~/$f ;
    done
}

case "$1" in
    "uninstall") uninstall ;;
    "uninstall-f") uninstall -f ;;
    *) install ;;
esac
