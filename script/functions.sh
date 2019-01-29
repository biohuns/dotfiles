#!/usr/bin/env bash

set -eu

require () {
    for c in "$@"
    do
        type "$c" > /dev/null
    done
}

create_symlink () {
    ln -snfv "$DIR/$1" "$HOME"/"$1"
}
