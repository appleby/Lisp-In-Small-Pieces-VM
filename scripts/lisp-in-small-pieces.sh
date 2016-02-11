#!/usr/bin/bash -x

echo "==> Setting hostname"
echo lisp-in-small-pieces-vm > /etc/hostname

echo "==> Installing git gambit-c and bigloo"
/usr/bin/pacman -S --noconfirm git gambit-c bigloo

echo "==> Creating tmpdir"
tmpdir=$(/usr/bin/mktemp --directory)
pushd ${tmpdir}

echo "==> Installing cower"
/usr/bin/curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
/usr/bin/tar xf cower.tar.gz

pushd cower
/usr/bin/gpg --recv-key 487EACC08557AD082088DABA1EB2638FF56C0C53
/usr/bin/makepkg -scri --noconfirm
popd

echo "==> Installing mit-scheme"
/usr/bin/cower -d mit-scheme
pushd mit-scheme
/usr/bin/makepkg -scri --noconfirm
popd
popd # Pop out of tmpdir

echo "==> Removing tmpdir"
rm -rf ${tmpdir}
