#!/usr/bin/env bash

set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"

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

# touch files
TOUCH_FILES=(
    .gitconfig_company
    .config/git/mailmap
)

for file in "${TOUCH_FILES[@]}"
do
    [[ ! -e "$DIR/$file"  ]] && touch "$DIR/$file" && echo "create:   $file"
done

# make symlinks
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

# vim
curl -s https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim -o ~/.vim/colors/darcula.vim

complete ".vim/colors"

# git
[[ ! -e "$HOME/.config/git" ]] && mkdir -p "$HOME/.config/git"

cd "$DIR" &&
for f in .config/git/*
do
    create_symlink "$f"
done

[[ ! -e "/usr/local/bin/diff-highlight" ]] &&
    ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin

# fish shell
[[ ! -e "$HOME/.config/fish" ]] && mkdir -p "$HOME/.config/fish"

cd "$DIR" && for f in .config/fish/*
do
    create_symlink "$f"
done

[[ "$SHELL" = "$(command -v fish)" ]] || (chsh -s "$(command -v fish)"; fish)

echo "Success!"
