#!/bin/sh
REPO="${HOME}/gentoo-vm"
WORLD=/var/lib/portage/world
DEST="${REPO}${WORLD}"

mkdir -p $(dirname "$DEST")
cp "$WORLD" "$DEST"
