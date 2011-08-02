# export PATH=~/.rvm/bin/:~/bin/:$PATH
export PATH=~/bin/:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

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
setopt autocd
unsetopt beep
unsetopt automenu
bindkey -e

for FILE in $(ls $HOME/.dotfiles/ext); do
  source $HOME/.dotfiles/ext/$FILE
done

source ~/.dotfiles/colors
source ~/.dotfiles/prompt
source ~/.dotfiles/aliases
# virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

[[ -s "/Users/travis/.rvm/scripts/rvm" ]] && source "/Users/travis/.rvm/scripts/rvm"
