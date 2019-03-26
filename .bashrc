# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

activate_virtualenv () {
    AC=env/bin/activate
    if [ -f $AC ]; then . $AC; echo . ;
    elif [ -f ../$AC ]; then . ../$AC; echo ..;
    elif [ -f ../../$AC ]; then . ../../$AC; echo ...;
    elif [ -f ../../../$AC ]; then . ../../../$AC; echo ....;
    fi
}
# https://github.com/mathiasbynens/dotfiles/blob/master/.functions
fs () {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}
mkcd () {
    mkdir -p $1 ;
    cd $1
}
lf () {
    ls $1 | wc -l
}
myip () {
	ifconfig | grep "inet addr" | head -n1 | sed -e 's/.*r://' -e 's/ .*//'
}
ldup () {
    for f in $(ls $1/duplicity-*.manifest.gpg); do
        echo "========================================================================"; 
        echo $f;
        n=$(basename $f .manifest.gpg);
        prefix=$(echo $n | awk 'BEGIN { FS = "." } ;{ print $1 }');
        if [[ "$prefix" == "duplicity-full" ]]; then
            t=$(echo $n | awk 'BEGIN { FS = "." } ;{ print $2 }');
        else
            t=$(echo $n | awk 'BEGIN { FS = "." } ;{ print $4 }');
        fi;
        echo -e "Creation time:\t" $t;
        echo "------------------------------------------------------------------------";
        duplicity list-current-files --time $t file://$1/ | grep "$2";
    done;
}

calctime () {
        tail *.log | grep "cpu time" | sed -e 's/^.*: *//' | awk '{total += ($1 * 24) + ($3) + ($5 / 60) + ($7 / 3600) } END {print total }'
}

calctime2 () {
        grep "cpu time" *.log | sed -e 's/^.*: *//' | awk '{total += ($1 * 24) + ($3) + ($5 / 60) + ($7 / 3600) } END {print total }'
}
calctime3 () {
	num=$(ls *.log | wc -l);
	grep "cpu time" *.log | sed -e 's/^.*: *//' | awk -v num="$num" '{total += ($1 * 24) + ($3) + ($5 / 60) + ($7 / 3600) } END {print total/num }'
}
gstat () {
        for f in $@ ; do
                echo $f $(ls $f/*.log 2> /dev/null | wc -l) $( grep 'Normal termination' $f/*.log 2> /dev/null | wc -l ) $( ls $f/*.gjf 2> /dev/null | wc -l);
        done
}
swap () {
    TMPFILE=$(mktemp $(dirname "$1")/XXXXXX)
    mv "$1" "$TMPFILE" && mv "$2" "$1" && mv "$TMPFILE" "$2";
}

# Swap caps and escape
#setxkbmap -option caps:swapescape

# Export variables
export VISUAL=vim
export EDITOR="$VISUAL"
export PATH=/usr/local/cuda-7.5/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/chris/projects/caffe/distribute/lib:$LD_LIBRARY_PATH
export PYTHONSTARTUP=/home/chris/.pystartup
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64


# Aliases
alias ll='ls -halF'
alias la='ls -A'
alias l='ls -CF'
alias fhere='find . -name'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias g='git'
alias gti='git'
alias mdkir='mkdir'
alias sr='screen -r'
alias p='python'
alias py='python'
alias cim='vim'
alias svim='sudo vim'
alias v='vim'
alias fileparser='python ~/projects/chemtools-webapp/chemtools/fileparser.py'
alias grepn='grep -l'
alias filter='tr -s " " | cut -d " " -f 9- | sed -e "s/\s*->.*//" | grep -vE "^(\.|\.\.)$"'
alias psg='ps aux | grep'
alias rsa='rsync -avz'
alias hist='history | grep'
alias hs='hist'
alias x='exit'
alias c='clear'
alias av='activate_virtualenv'
alias reswap='sudo swapoff -a && sudo swapon -a'
alias serve='python -m SimpleHTTPServer'
alias serve3='python -m http.server'
alias rn='ranger'
alias pdf='zathura'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
