# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

source /usr/share/nvm/init-nvm.sh

relative-to () {
	# relative-to dir path
	# like realpath --relative-to=dir path
	DIR=$(readlink -f "$1")
	PATH=$(readlink -f "$2")
	echo "${PATH#"$DIR/"}"
}

git-pwd () {
	if git rev-parse >& /dev/null; then
		relative-to "$(git rev-parse --git-dir)/../.." ./
	else
		dirs +0
	fi
}

git-bump () {
    # args: master dev
    MASTER="${1:-master}"
    DEV="${2:-dev}"
    git checkout "$MASTER" && git merge --ff "$DEV" && git push && git checkout "$DEV"
}

alias mon1='tmux new-session -s mon'

mon2 () {
    # htop
    tmux send 'sudo LANG=C htop' 'C-j'

    # battery
    tmux split-window -l "50%"
    tmux send 'watch acpi -bit' 'C-j'

    # terminal
    tmux split-window -l "50%"

    # bluetooth
    tmux split-window -h -t 1
    tmux send 'bluetoothctl' 'C-j' 'C-l'

    # select htop
    tmux select-pane -t 0
}

t-sp () {
    if [[ $(tput lines) -eq 66 ]]; then
        tmux split-window -l "25%"
    else
        tmux split-window
    fi
}

t-vs () {
    if [[ $(tput cols) -eq 265 ]]; then
        tmux split-window -h -l "33%"
    else
        tmux split-window -h
    fi
}

enable-core-dumps () {
    ulimit -c unlimited
    echo core | sudo tee /proc/sys/kernel/core_pattern
}

# Put your fun stuff here.

if [ $(uname -s) == "OpenBSD" ]; then
	alias ls="ls -hF"
else
	alias ls="ls -h --color=auto"
fi

alias ll="ls -l"
alias la="ll -a"
alias Less="less -RSFX"
alias reset="tput reset"
alias nano="nano -w"
alias bell="echo -ne \"\x07\""
alias hibernate="systemctl hibernate && exit"
alias suspend="systemctl suspend && exit"
alias ignore="systemd-inhibit --what=handle-lid-switch sleep infinity"
alias ssh-umich="ssh -X -L 5951:localhost:5951 umich"

source ~/.git-prompt.sh
PS1='$(printf "%.*s" $? $?)\[\e[01;32m\]\u@\h: \[\e[00m\]$(date "+%X"): \[\e[01;34m\]$(git-pwd): \[\e[00m\]$(__git_ps1 "%s:")\n\$ \[\e[00m\]'
export EDITOR=vim
export MANPAGER=less
export PAGER="less -RSFX"
export PATH="$PATH:$HOME/.rvm/bin"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export MANPATH="$MANPATH:$HOME/.local/share/man"
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.sock
export SUDO_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
export LFS=/mnt/lfs
export _JAVA_AWT_WM_NONREPARENTING=1

git-new () {
	FILE=$1
	touch "$FILE"
	git add -N "$FILE"
	$EDITOR "$FILE"
}
