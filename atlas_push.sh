#!/usr/bin/env bash

# Stolen from wrapacker
if [[ -f /etc/arch-release ]]; then
	readonly PACKER_BIN='packer-io'
else
	readonly PACKER_BIN='packer'
fi

source atlas_env.sh
$PACKER_BIN push arch-template.json
