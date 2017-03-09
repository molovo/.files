#!/usr/bin/env zsh

typeset -Uga fpath path
path=($(cat ${ZULU_CONFIG_DIR:-"${ZDOTDIR:-$HOME}/.config/zulu"}/path))
fpath=($(cat ${ZULU_CONFIG_DIR:-"${ZDOTDIR:-$HOME}/.config/zulu"}/fpath))
