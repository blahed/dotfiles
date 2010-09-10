export PATH=/opt/local/bin:/opt/local/sbin:/opt/local/lib/postgresql83/bin:~/bin/:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export LSCOLORS='Gxcxfxfxfxdxdxhbadbxbx'

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

source ~/.dotfiles/prompt
source ~/.dotfiles/aliases
