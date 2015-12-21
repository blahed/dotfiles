export PATH=$HOME/bin/:$HOME/.rbenv/bin:/usr/local/bin:$PATH
export GOPATH=$HOME/.go
export MANPATH=/opt/local/share/man:$MANPATH
# nano is the default sucka!
export EDITOR="nano"

zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*' menu select=20
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
unsetopt automenu
bindkey -e
setopt auto_cd
cdpath=($HOME/Dev)

EXT_DOTS=$HOME/.dotfiles/ext

if [ -d "$EXT_DOTS" ]; then
  for FILE in $(ls $EXT_DOTS); do
    source $EXT_DOTS/$FILE
  done
fi

source ~/.dotfiles/colors
source ~/.dotfiles/prompt
source ~/.dotfiles/aliases

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# rbenv
eval "$(rbenv init -)"
