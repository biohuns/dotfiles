#!/usr/bin/env bash
set -eu

DIR="$(cd "$(dirname "$0")"/../ && pwd)"

complete() {
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

require fish

for f in .??*
do
    # ignore .example
    [[ "$f" = *".example" ]] && continue
    # ignore git
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    # ignore .DS_Store
    [ "$f" = ".DS_Store" ] && continue
    # ignore .config
    [ "$f" = ".config" ] && continue
    # ignore .circleci
    [ "$f" = ".circleci" ] && continue

    create_symlink "$f"
done

# vim
curl -s https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim -o ~/.vim/colors/darcula.vim
complete ".vim/colors"

# git
[ ! -e "$HOME/.config/git" ] && mkdir -p "$HOME/.config/git"
for f in .config/git/*
do
    create_symlink "$f"
done

# fish shell
[ ! -e "$HOME/.config/fish" ] && mkdir -p "$HOME/.config/fish"
for f in .config/fish/*
do
    create_symlink "$f"
done
[ "$SHELL" = "$(command -v fish)" ] || (chsh -s "$(command -v fish)"; fish)

echo "Success!"
