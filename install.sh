#!/usr/bin/env bash

set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"

###############
## Functions ##
###############

complete () {
    echo "complete: $1"
}

require () {
    for c in "$@"; do
        type "$c" > /dev/null
    done
}

create_symlink () {
    ln -snfv "$DIR/$1" "$HOME"/"$1" > /dev/null
    complete "$1"
}

TOUCH_FILES=(
    .gitconfig_company
    .config/git/mailmap
)

###############
##  Install  ##
###############

## Create File ##

for file in "${TOUCH_FILES[@]}"
do
    if [[ ! -e $DIR/$file  ]]; then
        touch "$DIR/$file"
        echo "create:   $file"
    fi
done

## Make Symlink ##

cd "$DIR" &&
for f in .??*
do
    [[ "$f" = ".DS_Store"  ]] && continue
    [[ "$f" = ".circleci"  ]] && continue
    [[ "$f" = ".config"    ]] && continue
    [[ "$f" = ".git"       ]] && continue
    [[ "$f" = ".gitignore" ]] && continue
    [[ "$f" = *".example"  ]] && continue

    create_symlink "$f"
done

## Vim ##

THEME="https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim"
if [[ ! -e $HOME/.vim/colors/darcula.vim ]]; then
    mkdir -p "$HOME/.vim/colors"
    curl -s $THEME -o ~/.vim/colors/darcula.vim
fi

complete ".vim/colors"

## Git ##

if [[ ! -e $HOME/.config/git ]]; then
    mkdir -p "$HOME/.config/git"
fi

cd "$DIR" &&
for f in .config/git/*
do
    create_symlink "$f"
done

if [[ ! -e /usr/local/bin/diff-highlight ]]; then
    ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin
fi

## powerline-shell ##

require powerline-shell
if [[ ! -e $HOME/.config/powerline-shell ]]; then
    mkdir -p "$HOME/.config/powerline-shell"
fi

cd "$DIR" &&
for f in .config/powerline-shell/*
do
    create_symlink "$f"
done

## Set Shell ##

if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)"
    zsh
fi

echo "Success!"
