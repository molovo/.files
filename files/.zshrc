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
    if ! pgrep gpg-agent >/dev/null 2>&1; then
      eval $(gpg-agent --daemon)
    fi
  fi
fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [[ -f "$HOME/.rvm/scripts/rvm" ]]; then
  export PATH="$PATH:$HOME/.rvm/bin"
  source /Users/molovo/.rvm/scripts/rvm
fi

# Emacs and Vi
for keymap in 'emacs' 'viins'; do
  builtin bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
  builtin bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/Users/molovo/.netlify/helper/path.zsh.inc' ]; then source '/Users/molovo/.netlify/helper/path.zsh.inc'; fi

# BEGIN SNIPPET: Platform.sh CLI configuration
HOME=${HOME:-'/Users/molovo'}
export PATH="$HOME/"'.platformsh/bin':"$PATH"
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi # END SNIPPET

autoload -U add-zsh-hook
set_shopify_store() {
  if ! command git rev-parse --is-inside-work-tree &>/dev/null; then
    return
  fi

  local GIT_ROOT=$(command git rev-parse --show-toplevel 2> /dev/null)
  if [[ -f "$GIT_ROOT/.shopifystore" ]]; then
    shopify theme list --store $(cat $GIT_ROOT/.shopifystore) 2>&1
  fi
}
add-zsh-hook chpwd set_shopify_store

