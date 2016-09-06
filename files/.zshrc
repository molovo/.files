zmodload 'zsh/zprof'

[[ -z $SSH_CONNECTION && -z $TMUX ]] && tmux -u

export EDITOR='vim'

export WATSON_DIR=~/.config/watson

# Initialise zulu plugin manager
source "${ZULU_DIR:-"${ZDOTDIR:-$HOME}/.zulu"}/core/zulu"
zulu init

if command type thefuck > /dev/null; then
  eval $(thefuck --alias)
fi
