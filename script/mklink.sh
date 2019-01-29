#!/usr/bin/env bash

set -eu

cd `dirname $0`/../
DIR=`pwd`

for f in .??*
do
    echo "$DIR$f"
    # ignore .git directory
    [ "$f" = ".git" ] && continue
    # ignore .DS_Store
    [ "$f" = ".DS_Store" ] && continue
    # ignore .config directory
    [ "$f" = ".git" ] && continue

    ln -snfv "$DIR/$f" "$HOME"/"$f"
done
