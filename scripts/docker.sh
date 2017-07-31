#!/usr/bin/env bash

set -eu

echo "==> Adding LiSP user"
/usr/bin/useradd --comment 'LiSP User' --create-home --user-group lisper
/usr/bin/install --directory --mode=750 /etc/sudoers.d
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_lisper
echo 'lisper ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_lisper
/usr/bin/chmod 0440 /etc/sudoers.d/10_lisper
