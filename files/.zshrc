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

# Link pinentry and gpg-agent
$(type gpg 2>&1 > /dev/null)
if [[ $? -eq 0 ]]; then
  if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
    GPG_TTY=$(tty)
    export GPG_TTY
  else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
  fi
fi

# Tag a new version release
(( $+functions[gt] )) || function gt() {
  git tag -s "v$1" -m "Release $1"
}

# Check if the current working directory is in a git repo
(( $+functions[is_in_git_repo] )) || function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

(( $+functions[git_files] )) || function git_files() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-tmux -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

(( $+functions[git_branches] )) || function git_branches() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

(( $+functions[git_tags] )) || function git_tags() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

(( $+functions[git_history] )) || function git_history() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

(( $+functions[git_remotes] )) || function git_remotes() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-tmux --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# A helper function to join multi-line output from fzf
(( $+functions[join-lines] )) || function join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

(( $+functions[bind-git-helper] )) || function bind-git-helper() {
  local char
  typeset -A widgets; widgets=( \
    f 'files' \
    t 'tags' \
    b 'branches' \
    h 'history' \
    r 'remotes' \
  )
  for key command in ${(@kv)widgets}; do
    echo $key
    echo $command
    eval "fzf-git-$command-widget() { local result=\$(git_$command | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-git-$command-widget"
    eval "bindkey '^g^$key' fzf-git-$command-widget"
  done
}

bind-git-helper
