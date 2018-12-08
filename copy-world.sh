#!/bin/sh
REPO="${HOME}/config-root"
WORLD=/var/lib/portage/world
DEST="${REPO}${WORLD}"

mkdir -p $(dirname "$DEST")
cp "$WORLD" "$DEST"
