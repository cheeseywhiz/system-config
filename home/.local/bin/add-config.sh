#!/bin/env sh
# [sudo -E] add-config.sh file

REPO="${HOME}/gentoo-vm"
CONFIG_FILE=$(realpath "$1")
PATH_IN_REPO=$(realpath --relative-base="$HOME" "$1")
PATH_IN_REPO=$(python -c "
config_file = \"${CONFIG_FILE}\"
home = \"${HOME}\"

if config_file.startswith(home):
	config_file = '/home' + config_file[len(home):]

print(config_file)
")
DEST="${REPO}${PATH_IN_REPO}"

mkdir -p $(dirname "$DEST")
mv "$CONFIG_FILE" "$DEST"
ln -s "$DEST" "$CONFIG_FILE"
chown -R "$(stat -c "%U:%G" "$REPO")" "${REPO}"
(cd "$REPO" && git add -N "$DEST")
