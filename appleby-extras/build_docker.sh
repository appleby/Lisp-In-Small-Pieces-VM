#!/bin/bash

VERSION=${1:?usage: build_docker.sh VERSION}
THISDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKER_FILE="$(dirname "${THISDIR}")/docker-template.json"

if [[ "${VERSION}" =~ ^v.*$ ]]; then
    echo "INVALID VERSION: should not start with 'v' - ${VERSION}" >&2
    exit 1
fi

# stolen from wrapacker
if [[ -f /etc/arch-release ]]; then
    readonly PACKER_BIN='packer-io'
else
    readonly PACKER_BIN='packer'
fi

${PACKER_BIN} build -var "version=${VERSION}" "${PACKER_FILE}"
