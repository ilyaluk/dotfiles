# todo(@ilyaluk) set up gopath here
export PATH=$HOME/.bin:$HOME/go/bin:$PATH

if [ "$(tty)" = "/dev/tty1" ]; then
	# Wayland tweaks
	export MOZ_ENABLE_WAYLAND=1
	export QT_QPA_PLATFORM=wayland
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

	# crutch for ssh-agent
	export SSH_AUTH_SOCK="$(mktemp -d /tmp/ssh-agent.XXXXXXXXXX)/agent"
	# Helps some Qt apps
	export XDG_SESSION_TYPE=wayland
	# dbus-launch helps Spotify to be controllable via Dbus, probably something else
	exec dbus-launch --exit-with-session sway
fi

[[ -f ~/.zshrc.grml ]] && source .zshrc.grml

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
bindkey -e
zstyle :compinstall filename "$USER/.zshrc"
autoload -Uz compinit
compinit

# source /usr/share/todoist/todoist_functions.sh

# Stop Ctrl+W on / and .
autoload -U select-word-style
select-word-style bash

# oh-my-zsh-like behavior for history search
bind2maps emacs viins       -- Up history-beginning-search-backward-end
bind2maps emacs viins       -- Down history-beginning-search-forward-end

alias py='python'
alias py2='python2'
alias hd='hexdump -C'
alias nn='nnn -H -d'
alias t='todoist'
alias -- -='cd -'
