#!/usr/bin/bash

set -e

echo "==> Setting hostname"
echo lisp-in-small-pieces-vm | sudo tee /etc/hostname > /dev/null

echo "==> Installing git bigloo indent and time"
sudo /usr/bin/pacman -S --noconfirm git bigloo indent time

echo "==> Creating tmpdir"
tmpdir=$(/usr/bin/mktemp --directory --tmpdir=${HOME})
pushd "$tmpdir"

echo "==> Installing mit-scheme"
# Chris Hanson <cph@chris-hanson.org>
/usr/bin/gpg --keyserver keys.gnupg.net --recv-keys C9E40BAAFD0CB132
/usr/bin/cp /tmp/PKGBUILD .
/usr/bin/makepkg -scri --noconfirm

echo "==> Installing auracle"
/usr/bin/curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/auracle-git.tar.gz
/usr/bin/tar xf auracle-git.tar.gz

pushd auracle-git
/usr/bin/makepkg -scri --noconfirm
popd

echo "==> Installing caml-light"
/usr/bin/git clone https://github.com/aur-archive/caml-light.git
pushd caml-light
/usr/bin/makepkg -scri --noconfirm
popd

popd # Pop out of tmpdir
echo "==> Removing tmpdir"
rm -rf "$tmpdir"
