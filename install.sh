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
    if [[ ! -e $DIR/$file  ]]; then
        touch "$DIR/$file"
        echo "create:   $file"
    fi
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
THEME="https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim"
if [[ ! -e $HOME/.vim/colors/darcula.vim ]]; then
    curl -s $THEME -o ~/.vim/colors/darcula.vim
fi

complete ".vim/colors"

# git
if [[ ! -e $HOME/.config/git ]]; then
    mkdir -p "$HOME/.config/git"
fi

cd "$DIR" &&
for f in .config/git/*
do
    create_symlink "$f"
done

if [[ ! -e /usr/local/bin/diff-highlight ]]; then
    ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin
fi

# fish shell
if [[ ! -e $HOME/.config/fish ]]; then
    mkdir -p "$HOME/.config/fish"
fi

cd "$DIR" &&
for f in .config/fish/*
do
    create_symlink "$f"
done

if [[ "$SHELL" != "$(command -v fish)" ]]; then
    chsh -s "$(command -v fish)"
    fish
fi

echo "Success!"
