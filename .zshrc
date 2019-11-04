HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
bindkey -e
zstyle :compinstall filename '/home/user/.zshrc'
autoload -Uz compinit
compinit

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl

export PATH=$HOME/.bin:$PATH

alias py='python'
alias py2='python2'
alias hd='hexdump -C'
alias nn='nnn -H -d'
alias t='task'
