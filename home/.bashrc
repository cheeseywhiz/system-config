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

git-pwd () {
	if git rev-parse >& /dev/null; then
		realpath --relative-to="$(git rev-parse --git-dir)/../.." ./
	else
		dirs +0
	fi
}

git-branch () {
	if git rev-parse >& /dev/null; then
		printf "(%s): " "$(git rev-parse --abbrev-ref HEAD)"
	fi
}

# Put your fun stuff here.
alias ls="ls -h --color=always"
alias ll="ls -l"
alias la="ll -a"
alias reset="tput reset"
alias nano="nano -w"

PS1='$(printf "%.*s" $? $?)\[\e[01;32m\]\u@\h: \[\e[00m\]$(date "+%X"): \[\e[01;34m\]$(git-pwd): \[\e[00m\]$(git-branch)\n\$ \[\e[00m\]'
export EDITOR=vim
export PATH="${PATH}:${HOME}/.local/bin"

git-new () {
	FILE=$1
	touch "$FILE"
	git add -N "$FILE"
	$EDITOR "$FILE"
}
