#!/usr/bin/env bash

set -eu

source $(dirname $0)/env.sh

require fish

# mkdir .config/fish
[ ! -e $HOME/$FISH_DIR ] && mkdir -p $HOME/$FISH_DIR

# make symlink
for f in $FISH_DIR/*
do
    create_symlink $f
done

[ "$SHELL" = "$(which fish)" ] || chsh -s $(which fish)
fish
