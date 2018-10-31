#!/usr/bin/env bash

set -eu

today="$(date +'%Y/%m/%d')"

echo "==> Pinning pacman mirrorlist to archive.archlinux.org"
echo "Server=https://archive.archlinux.org/repos/${today}/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo "==> Syncing pacman database"
pacman -Syy
