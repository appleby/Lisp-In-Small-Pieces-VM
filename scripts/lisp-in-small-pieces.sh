#!/usr/bin/bash

set -e

echo "==> Setting hostname"
echo lisp-in-small-pieces-vm | sudo tee /etc/hostname > /dev/null

echo "==> Installing git gambit-c bigloo indent and time"
sudo /usr/bin/pacman -S --noconfirm git mit-scheme gambit-c bigloo time

echo "==> Creating tmpdir"
tmpdir=$(/usr/bin/mktemp --directory --tmpdir=${HOME})
pushd ${tmpdir}

echo "==> Installing cower"
/usr/bin/curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
/usr/bin/tar xf cower.tar.gz

pushd cower
# IPv4 is required for the docker builder.
/usr/bin/gpg --keyserver ipv4.pool.sks-keyservers.net --recv-key 487EACC08557AD082088DABA1EB2638FF56C0C53
/usr/bin/makepkg -scri --noconfirm
popd

echo "==> Installing indent"
/usr/bin/cower -d indent
pushd indent
/usr/bin/makepkg -scri --noconfirm
popd

echo "==> Installing caml-light"
/usr/bin/git clone https://github.com/aur-archive/caml-light.git
pushd caml-light
/usr/bin/makepkg -scri --noconfirm
popd

popd # Pop out of tmpdir
echo "==> Removing tmpdir"
rm -rf ${tmpdir}
