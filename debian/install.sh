#!/usr/bin/env bash

set -eu
umask 0022

GIT_ROOT=$(cd "$(dirname "$0")" && pwd)
USR_BIN_DIR=/usr/local/bin

DEPENDENCIES='zsh git vim curl tmux python python-pip tig make shellcheck gawk man golang-1.14 unzip sqlite3'
JQ_BIN='https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'

VIM_COLOR_DIR=.vim/colors
VIM_COLOR_SRC=https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim
VIM_COLOR_DST=$HOME/$VIM_COLOR_DIR/darcula.vim

GIT_ACCOUNT=.gitaccount
GIT_CONFIG_DIR=.config/git
DIFF_HIGHLIGHT_SRC_DIR=/usr/share/doc/git/contrib/diff-highlight
DIFF_HIGHLIGHT_SRC=$DIFF_HIGHLIGHT_SRC_DIR/diff-highlight
DIFF_HIGHLIGHT_DST=$USR_BIN_DIR/diff-highlight

ZPLUG_DIR="$HOME"/.zplug

#####################
##### Functions #####
#####################

green_message() {
    printf '\033[32m%s\033[m\n' "$1"
}

require() {
    for c in "$@"; do
        type "$c" >/dev/null
    done
}

create_symlink() {
    ln -snfv "$GIT_ROOT"/"$1" "$HOME"/"$1" >/dev/null
    green_message "complete: $1"
}

#####################
#####  Install  #####
#####################

##### Dependencies #####

# shellcheck disable=SC2086
sudo apt install -y $DEPENDENCIES

if [[ ! -e $USR_BIN_DIR/jq ]]; then
    sudo curl -L $JQ_BIN -o $USR_BIN_DIR/jq
    sudo chmod +x $USR_BIN_DIR/jq
fi
require jq

# Create File

if [[ ! -e $GIT_ROOT/$GIT_ACCOUNT ]]; then
    cp "$GIT_ROOT"/$GIT_ACCOUNT{.example,}
    green_message "create:   $GIT_ACCOUNT"
fi

# Make Symlink

cd "$GIT_ROOT" && for f in .??*; do
    [[ "$f" = .config ]] && continue
    [[ "$f" = .git ]] && continue
    [[ "$f" = .gitignore ]] && continue
    [[ "$f" = *.example ]] && continue

    create_symlink "$f"
done

# Vim

if [[ ! -e $VIM_COLOR_DST ]]; then
    mkdir -p "$HOME"/$VIM_COLOR_DIR
    curl -s $VIM_COLOR_SRC -o "$VIM_COLOR_DST"
fi
green_message "complete: $VIM_COLOR_DIR"

# Git

mkdir -p "$HOME"/$GIT_CONFIG_DIR
create_symlink $GIT_CONFIG_DIR/attributes
create_symlink $GIT_CONFIG_DIR/ignore

# diff-highlight

if [[ ! -e $DIFF_HIGHLIGHT_DST ]]; then
    cd "$DIFF_HIGHLIGHT_SRC_DIR" && sudo make
    sudo ln -snfv $DIFF_HIGHLIGHT_SRC $USR_BIN_DIR
fi
require diff-highlight
green_message "complete: diff-highlight"

# powerline-shell

sudo pip install -U powerline-shell
require powerline-shell

mkdir -p "$HOME"/.config/powerline-shell
POWERLINE_SHELL_LOCATION=$(sudo pip show powerline-shell | grep Location: | cut -d' ' -f2)
POWERLINE_SHELL_CONF=$POWERLINE_SHELL_LOCATION/powerline_shell/themes/default.py
POWERLINE_SHELL_CONF_DST="$GIT_ROOT"/.config/powerline-shell/config.json
jq ".theme=\"$POWERLINE_SHELL_CONF\"" \
    "$POWERLINE_SHELL_CONF_DST".example \
    >"$POWERLINE_SHELL_CONF_DST"
create_symlink .config/powerline-shell/config.json

# Set Shell
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    sudo chsh -s "$(command -v zsh)"
    zsh
fi

# ZPlug
if [[ ! -e $ZPLUG_DIR ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

green_message "Success!"
exit 0
