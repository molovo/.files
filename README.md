# .files

My dotfiles

## Installation

```sh
zsh
git clone --recursive https://github.com/molovo/.files "${ZDOTDIR:-$HOME}/.files"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.files/files/*; do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/${rcfile:t}"
done

chsh -s /bin/zsh
```
