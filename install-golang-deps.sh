#!/bin/bash

# usage: install-golang-deps.sh
# desc:  install golang dep-packages such as godef goimports.

set -e

nowd=`date '+%Y-%m-%d'`
nowh=`date '+%Y-%m-%d-%H'`
nowm=`date '+%Y-%m-%d-%H-%M-%S.%3N'`

if [ "$GOPATH" == "" ]; then
    mkdir -p /home/gopath
    export GOPATH=/home/gopath
    export PATH=$PATH:$GOPATH/bin
fi

echo GOPATH=$GOPATH
echo PATH=$PATH

function git_clone_to {
    src=$1
    dst=$2
    if ! [ -d $dst ]; then
        echo exec git clone $src to $dst
        git clone $src $dst
    else
        echo skip git clone $src to $dst
    fi
}

git_clone_to https://github.com/rogpeppe/godef             $GOPATH/src/github.com/rogpeppe/godef
git_clone_to https://github.com/nsf/gocode                 $GOPATH/src/github.com/nsf/gocode
git_clone_to https://github.com/golang/lint                $GOPATH/src/golang.org/x/lint
git_clone_to https://github.com/golang/tools               $GOPATH/src/golang.org/x/tools
go install github.com/rogpeppe/godef
go install golang.org/x/lint/golint
go install golang.org/x/tools/cmd/guru
go install golang.org/x/tools/cmd/goimports
go install golang.org/x/tools/cmd/gorename
