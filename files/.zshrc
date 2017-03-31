#!/usr/bin/env zsh

setopt CORRECT

[[ "$TERM_PROGRAM" != "Hyper" && -z $SSH_CONNECTION && -z $TMUX ]] && tmux -u

# Initialise zulu plugin manager
source "${ZULU_DIR:-"${ZDOTDIR:-$HOME}/.zulu"}/core/zulu"
zulu init --next

if builtin type thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
fi

if [[ -f "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi

# Link pinentry and gpg-agent
if builtin type gpg >/dev/null 2>&1 && builtin type gpg-agent >/dev/null 2>&1; then
  if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
    GPG_TTY=$(tty)
    export GPG_TTY
  else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
  fi
fi
