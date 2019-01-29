#!/usr/bin/env bash

set -eu

source $(dirname $0)/env.sh

require fish

# mkdir .config/fish
[ ! -e $HOME/.config/fish ] && mkdir -p $HOME/.config/fish

# make symlink
for f in .config/fish/*
do
    create_symlink $f
done

# set fish to default shell
[ "$SHELL" = "$(which fish)" ] || chsh -s $(which fish)
fish
