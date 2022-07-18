#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/projects ~/work/email ~ ~/work -mindepth 1 -maxdepth 1 -type d | sed "s#$HOME#~#" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
selected=`echo $selected | sed "s#~#$HOME#"`

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $name nnn $selected
    exit 0
fi

if ! tmux has-session -t=$name 2> /dev/null; then
    tmux new-session -ds $name nnn $selected
fi

tmux switch-client -t $name || tmux attach-session -t $namE
