#!/usr/bin/env zsh

typeset -Uga fpath
fpath=($(cat ${ZULU_CONFIG_DIR:-"${ZDOTDIR:-$HOME}/.config/zulu"}/fpath))
