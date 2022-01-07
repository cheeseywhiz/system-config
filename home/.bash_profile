export BASH_SILENCE_DEPRECATION_WARNING=1

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# run bashrc in interactive shells
[[ -f ~/.bashrc ]] && [[ $- == *i* ]] && source ~/.bashrc
