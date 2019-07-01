#!/usr/bin/env bash

set -eu

source $(dirname $0)/env.sh

require fish

for f in .??*
do
    # ignore git
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    # ignore .DS_Store
    [ "$f" = ".DS_Store" ] && continue
    # ignore .config
    [ "$f" = ".config" ] && continue

    create_symlink $f
done

# vim
curl https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim -o ~/.vim/colors/darcula.vim

# git
[ ! -e $HOME/.config/git ] && mkdir -p $HOME/.config/git
for f in .config/git/*
do
    create_symlink $f
done

# fish shell
[ ! -e $HOME/.config/fish ] && mkdir -p $HOME/.config/fish
for f in .config/fish/*
do
    create_symlink $f
done
[ "$SHELL" = "$(which fish)" ] || (chsh -s $(which fish); fish)
