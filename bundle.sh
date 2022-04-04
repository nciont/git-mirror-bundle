#!/bin/bash

set -e

function main() {
    tempdir="$(mktemp -d)"
    reponame="$(basename $1 | cut -d '.' -f 1)"
    pushd $tempdir
    git clone --mirror "$1" repo
    pushd repo
    git bundle create ../bundle.pack --all
    bundlesrc="$(readlink -f ../bundle.pack)"
    pushd -0
    mv $bundlesrc "${reponame}.pack"
    rm -rf "${tempdir}"
}

if [ -z $1 ]; then
    echo 'Not enough arguments'
    exit 1
fi

main $1
