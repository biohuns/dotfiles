#!/usr/bin/env bash

set -eux

source $(dirname $0)/env.sh

require vim

# make symlink
create_symlink .vimrc

# setup Vundle
[ ! -e $HOME/.vim/bundle/Vundle.vim ] &&
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
vim +PluginClean +qall
