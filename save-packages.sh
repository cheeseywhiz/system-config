#!/usr/bin/env bash

command-exists() {
	command -v "$1" >& /dev/null
}

main() {
	if command-exists emerge; then  # Gentoo
		REPO="${HOME}/gentoo-vm"
		WORLD=/var/lib/portage/world
		DEST="${REPO}${WORLD}"
		mkdir -p $(dirname "$DEST")
		cp "$WORLD" "$DEST"
	elif command-exists pkg_info; then  # OpenBSD
		pkg_info -mz > openbsd-packages.txt
	fi
}

main
