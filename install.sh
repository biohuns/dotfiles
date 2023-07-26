#!/usr/bin/env bash

set -eu
umask 0022

ROOT="$(cd "$(dirname "$0")" && pwd)"
BIN='/usr/local/bin'

###############
## Functions ##
###############

green_message() {
    printf '\033[32m%s\033[m\n' "$1"
}

create_symlink() {
    ln -snf "$ROOT/$1" "$HOME/$1" >/dev/null
    green_message "mklink:   $1"
}

###############
##  Install  ##
###############

# create file

# vim
mkdir -p "$HOME/.vim/colors"
VIM_COLOR_SRC='https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim'
curl -s $VIM_COLOR_SRC -o "$HOME/.vim/colors/darcula.vim"
create_symlink .vimrc

# git
create_symlink .gitconfig
mkdir -p "$HOME/.config"
create_symlink ".config/git"

# diff-highlight
DH_SRC='/usr/share/doc/git/contrib/diff-highlight/diff-highlight'
DH_DST="$BIN/diff-highlight"
if [ ! -e $DH_DST ]; then
    sudo ln -snf $DH_SRC $DH_DST
    sudo chmod +x $DH_SRC
    green_message 'mklink:   diff-highlight'
fi

# make other symlinks
create_symlink .bashrc
create_symlink .bash_completion
create_symlink .tigrc
create_symlink .tmux.conf

green_message "Success!"
exit 0
