#!/bin/bash

set -eu
set -o pipefail

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

err() { echo "ERROR: $@" >&2 && exit 1; }

link_config_file() {
    local SOURCE=$1
    local DEST=$2

    if [[ ! -e "$DEST" ]] ; then
        ln -sf "$BASE_DIR/$SOURCE" "$DEST"
    else
        echo "WARNING: Skipping $SOURCE as $DEST already exists"
    fi
}

HAS_GIT=$(type git >/dev/null 2>&1 && echo 1)
HAS_TMUX=$(type tmux >/dev/null 2>&1 && echo 1)
HAS_PSQL=$(type psql >/dev/null 2>&1 && echo 1)
HAS_VIM=$(type vim >/dev/null 2>&1 && echo 1)

OH_MY_ZSH_REPO=git://github.com/robbyrussell/oh-my-zsh.git

[[ -n "$HAS_GIT" ]] || err "git is not installed"

echo "Setting up git"
link_config_file gitconfig ~/.gitconfig
touch ~/.gitconfig.local

if [[ $(basename "$SHELL") == "zsh" ]] ; then
    echo "Setting up zsh"
    [[ -d ~/.oh-my-zsh ]] || git clone "$OH_MY_ZSH_REPO" ~/.oh-my-zsh
    link_config_file zshrc ~/.zshrc
    touch ~/.zshrc.local
fi

if [[ -n "$HAS_TMUX" ]] ; then
    echo "Setting up tmux"
    link_config_file tmux.conf ~/.tmux.conf
    touch ~/.tmux.conf.local
fi

if [[ -n "$HAS_PSQL" ]] ; then
    echo "Setting up psql"
    link_config_file psqlrc ~/.psqlrc
    touch ~/.psqlrc.local
fi

if [[ -n "$HAS_VIM" ]] ; then
    echo "Setting up vim"
    link_config_file vimrc ~/.vimrc
    touch ~/.vimrc.local

    mkdir -p ~/.vim/bundle
    link_config_file vim/bundle ~/.vim/bundle
fi

echo "Done!"
