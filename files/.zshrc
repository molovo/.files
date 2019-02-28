#!/usr/bin/env zsh

setopt CORRECT

# Initialise zulu plugin manager
source "${ZULU_DIR:-"${ZDOTDIR:-$HOME}/.zulu"}/core/zulu"
zulu init --dev

[[ "$TERM_PROGRAM" != "vscode" && -z $SSH_CONNECTION && -z $TMUX ]] && tmux

if builtin type thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
fi

if [[ -f "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi

# Link pinentry and gpg-agent
if builtin type gpg >/dev/null 2>&1 && builtin type gpg-agent >/dev/null 2>&1; then
  if test -f $HOME/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
    source $HOME/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
    GPG_TTY=$(tty)
    export GPG_TTY
  else
    eval $(gpg-agent --daemon)
  fi
fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [[ -f "$HOME/.rvm/scripts/rvm" ]]; then
  export PATH="$PATH:$HOME/.rvm/bin"
  source /Users/molovo/.rvm/scripts/rvm
fi

# Enable vi-mode
bindkey -v

# Prevent the delay when switching mode
KEYTIMEOUT=5

# Print DCS characters around an escape sequence
function print_dcs {
  print -n -- "\EP$1;\E$2\E\\"
}

function set_cursor_shape {
  if [ -n "$TMUX" ]; then
    # tmux will only forward escape sequences to the terminal if surrounded by
    # a DCS sequence
    print_dcs tmux "\E]50;CursorShape=$1\C-G"
  else
    print -n -- "\E]50;CursorShape=$1\C-G"
  fi
}

function zle-keymap-select zle-line-init {
  case $KEYMAP in
    vicmd)
      set_cursor_shape 0 # block cursor
      ;;
    *)
      set_cursor_shape 1 # line cursor
      ;;
  esac
  zle reset-prompt
  zle -R
}

function zle-line-finish
{
  set_cursor_shape 1 # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Emacs and Vi
for keymap in 'emacs' 'viins'; do
  builtin bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
  builtin bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
done


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
