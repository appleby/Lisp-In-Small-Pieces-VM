#!/usr/bin/env bash

source atlas_env.sh
artifact_types="virtualbox vmware"
version="latest"

function usage() {
    cat <<-EOF >&2
	usage: $0 [-h] [-a ARTIFACT_TYPE] [-v VERSION]
EOF
}

function parse_opts() {
    while [[ $1 ]]; do
	case $1 in
	    -a | --artifact_types)
		artifact_types=$2
		shift
		;;
	    --artifact_types=*)
		artifact_types=${1#*=}
		;;
	    -v | --version)
		version=$2
		shift
		;;
	    --version=*)
		version=${1#*=}
		;;
	    -h | --help)
		usage
		exit 0
		;;
	    *)
		warn "unknown option $1"
		usage
		exit 1
		;;
	esac
	shift
    done
}

function get_file_version() {
    local version=$1;
    if [[ $version =~ ^[[:digit:]]+ ]]
    then
	# The Atlas api expects unadorned numeric artifact versions, but
	# we want to use v0.x for the file names.
	echo "v0.$version"
    else
	# If $version is non-numeric, then it's probably
	# "latest". Either way, return it unmodified.
	echo $version
    fi
}

function mkurl() {
    local artifact_type=$1
    local version=$2
    echo https://atlas.hashicorp.com/api/v1/artifacts/$ATLAS_USERNAME/$ATLAS_NAME/$artifact_type.image/$version/file
}

function mkfilename() {
    local artifact_type=$1
    local file_version=$(get_file_version $2)
    echo lisp-in-small-pieces-$artifact_type-$file_version.tar.gz
}

parse_opts "$@"

for artifact_type in $artifact_types
do
    fname=$(mkfilename $artifact_type $version)
    url=$(mkurl $artifact_type $version)
    /usr/bin/curl -L -o $fname $url
    /usr/bin/sha256sum $fname > $fname.sha256sum
done
