# todo(@ilyaluk) set up gopath here
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/go/bin:$PATH

# NPM thingies
NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

[[ -f ~/.zshrc.grml ]] && source ~/.zshrc.grml
[[ -f /etc/bash_completion.d/g4d ]] && source /etc/bash_completion.d/g4d

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
bindkey -e
zstyle :compinstall filename "$USER/.zshrc"
autoload -Uz compinit
compinit

zstyle ':prompt:grml:left:setup' items change-root user at host path vcs rc percent
zstyle ':prompt:grml:right:setup' items
if [[ "$HOST" != "nix" ]]; then
  zstyle ':prompt:grml:*:items:host' pre '%F{red}'
  zstyle ':prompt:grml:*:items:host' post '%F{white}'
fi

source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[comment]=fg=blue

# Stop Ctrl+W on / and .
autoload -U select-word-style
select-word-style bash

my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word


# oh-my-zsh-like behavior for history search
bind2maps emacs viins       -- Up history-beginning-search-backward-end
bind2maps emacs viins       -- Down history-beginning-search-forward-end

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

alias py='python3'
alias py2='python2'
alias hd='hexdump -C'
alias nn='nnn -H -d'
alias -- -='cd -'
alias ip='ip -color'
alias diff=colordiff
alias bell='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'
