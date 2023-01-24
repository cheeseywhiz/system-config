relative-to () {
	# relative-to dir path
	# like realpath --relative-to=dir path
	DIR=$(realpath "$1")
	PATH_=$(realpath "$2")
	echo "${PATH_#"$DIR/"}"
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

git-new () {
	FILE=$1
	touch "$FILE"
	git add -N "$FILE"
	$EDITOR "$FILE"
}

export EDITOR=vim
export PAGER=less
export MANPAGER=less

if [[ "$(uname)" == "Darwin" ]]; then
    export LESS="-RS"
else
    export LESS="-RSX"
fi

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ls="ls -h --color=auto"
alias ll="ls -l"
alias la="ll -a"
alias reset="tput reset"
alias bell="echo -ne \"\x07\""
#alias ssh-umich="ssh -X -L 5951:localhost:5951 umich"
alias t-sp="tmux split-window -l \"25%\""
alias t-vs="tmux split-window -h -l \"37%\""

if [[ "$(uname)" == "Darwin" ]]; then
    alias code="open -a \"Visual Studio Code\""
    alias chrome="open -a \"Google Chrome\""
    alias qemu="qemu-system-aarch64"
fi

## set PATH
export PATH="$HOME/.local/bin-override:$PATH"
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if [[ -d "$XDG_CONFIG_HOME/nvm" ]]; then
    export NVM_DIR="$XDG_CONFIG_HOME/nvm"
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [[ "$(uname)" == "Darwin" ]]; then
    case $(uname -m) in
        x86_64)
            [[ -s /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
            # brew --prefix openjdk
            [[ -d /usr/local/opt/openjdk ]] && export PATH="/usr/local/opt/openjdk/bin:$PATH"
            ;& # fallthrough
        arm64)
            [[ -s /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
            # brew --prefix openjdk
            [[ -d /opt/homebrew/opt/openjdk ]] && export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
            ;;
    esac
fi

export PATH="$PATH:$HOME/.local/bin"
export MANPATH="$MANPATH:$HOME/.local/share/man"
# set indefinite size history
export HISTSIZE=-1
export HISTTIMEFORMAT="%F %T "

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    # I think this is done automatically:
    #export PATH="$PATH:$HOME/.rvm/bin"
fi

if command -v starship >& /dev/null; then
    eval "$(starship init bash)"
else
    source ~/.git-prompt.sh
    PS1='$(printf "%.*s" $? $?)\[\e[01;32m\]\u@\h: \[\e[00m\]$(date "+%r"): \[\e[01;34m\]$(git-pwd): \[\e[00m\]$(__git_ps1 "%s:")\n\$ \[\e[00m\]'
fi
