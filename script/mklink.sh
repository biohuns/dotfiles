#!/usr/bin/env bash

set -eu

source $(dirname $0)/env.sh

for f in .??*
do
    # ignore .git directory
    [ "$f" = ".git" ] && continue
    # ignore .DS_Store
    [ "$f" = ".DS_Store" ] && continue
    # ignore .config directory
    [ "$f" = ".config" ] && continue

    create_symlink $f
done
