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

require() {
    for c in "$@"; do
        type "$c" >/dev/null
    done
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
create_symlink .vimrc
mkdir -p "$HOME/.vim/colors"
VIM_COLOR_SRC='https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim'
curl -s $VIM_COLOR_SRC -o "$HOME/.vim/colors/darcula.vim"
green_message "mklink:   .vim/colors"

# git
create_symlink .gitconfig
[[ ! -e $ROOT/.gitaccount ]] && cp "$ROOT"/.gitaccount{.example,}
create_symlink .gitaccount
mkdir -p "$HOME/.config/git"
create_symlink ".config/git/attributes"
create_symlink ".config/git/ignore"

# diff-highlight
DH_SRC='/usr/local/share/git-core/contrib/diff-highlight/diff-highlight'
DH_DST="$BIN/diff-highlight"
sudo ln -snf $DH_SRC $DH_DST
require diff-highlight
green_message 'mklink:   diff-highlight'

# powerline-shell

pip3 install -qU powerline-shell
require powerline-shell
green_message 'install:  powerline-shell'

PS_THEME=$(pip3 show powerline-shell | grep Location | cut -d' ' -f2)/powerline_shell/themes/default.py
jq ".theme=\"$PS_THEME\"" \
    "$ROOT/.config/powerline-shell/config.json.example" \
    > "$ROOT/.config/powerline-shell/config.json"
mkdir -p "$HOME/.config/powerline-shell"
create_symlink .config/powerline-shell/config.json

# karabiner-elements
mkdir -p "$HOME/.config/karabiner"
create_symlink .config/karabiner/karabiner.json

# make other symlinks
create_symlink .zshrc
create_symlink .tigrc
create_symlink .tmux.conf
create_symlink .gemrc
create_symlink .digrc

# set shell
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)"
    zsh
fi

# zplug
ZPLUG_DIR="$HOME/.zplug"
if [[ ! -e $ZPLUG_DIR ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

green_message "Success!"
exit 0
