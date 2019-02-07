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

# Put your fun stuff here.

if [ $(uname -s) == "OpenBSD" ]; then
	alias ls="ls -hF"
else
	alias ls="ls -h --color=auto"
fi

alias ll="ls -l"
alias la="ll -a"
alias reset="tput reset"
alias nano="nano -w"

source ~/.git-prompt.sh
PS1='$(printf "%.*s" $? $?)\[\e[01;32m\]\u@\h: \[\e[00m\]$(date "+%X"): \[\e[01;34m\]$(git-pwd): \[\e[00m\]$(__git_ps1 "%s:")\n\$ \[\e[00m\]'
export EDITOR=vim
export MANPAGER=less
export PATH="${PATH}:${HOME}/.local/bin"
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.sock
export SUDO_ASKPASS=/usr/lib/ssh/x11-ssh-askpass

git-new () {
	FILE=$1
	touch "$FILE"
	git add -N "$FILE"
	$EDITOR "$FILE"
}
