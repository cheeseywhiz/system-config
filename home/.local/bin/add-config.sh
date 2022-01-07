#!/usr/bin/env bash
# [sudo -E] add-config.sh file

REPO="${HOME}/system-config"

repo-owner () {
    case $(uname) in
        Darwin)
            stat -f "%Su:%Sg" "$REPO"
            ;;
        OpenBSD)
            stat -f "%u:%g" "$REPO"
            ;;
        Linux)
            stat -c "%U:%G" "$REPO"
            ;;
    esac
}

CONFIG_FILE="$1"

# if already added then stop
if [[ -L "$CONFIG_FILE" ]]; then
    exit
fi

chown -Rv "$(repo-owner)" "$CONFIG_FILE"

PATH_IN_REPO="$(python -c "
config_file = \"${CONFIG_FILE}\"
home = \"${HOME}\"

if config_file.startswith(home):
	config_file = 'home' + config_file[len(home):]

if config_file.startswith('/'):
	config_file = config_file[1:]

print(config_file)
")"
DEST="${REPO}/${PATH_IN_REPO}"

mkdir -pv $(dirname "$DEST")
mv -v "$CONFIG_FILE" "$DEST"
ln -sv "$DEST" "$CONFIG_FILE"
(cd "$REPO" && git add -Nv "$DEST")
