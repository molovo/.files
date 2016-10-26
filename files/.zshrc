zmodload 'zsh/zprof'

[[ "$TERM_PROGRAM" != "Hyper" && -z $SSH_CONNECTION && -z $TMUX ]] && tmux -u

export EDITOR='vim'

export WATSON_DIR=~/.config/watson

# Initialise zulu plugin manager
source "${ZULU_DIR:-"${ZDOTDIR:-$HOME}/.zulu"}/core/zulu"
zulu init

if command type thefuck > /dev/null; then
  eval $(thefuck --alias)
fi

zstyle ':zsh-hints:*:' dir "~/.zulu/share"

zle -N zsh-hints-param zsh-hints
bindkey "^Xp" zsh-hints-param
zle -N zsh-hints-paramflags zsh-hints
bindkey "^Xf" zsh-hints-paramflags
zle -N zsh-hints-glob zsh-hints
bindkey "^Xg" zsh-hints-glob

if [[ -f "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi
