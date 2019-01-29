#!/usr/bin/env bash

set -eu

source $(dirname $0)/env.sh

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
