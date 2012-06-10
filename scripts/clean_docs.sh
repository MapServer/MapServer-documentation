#!/bin/bash

args=("$@")
BRANCH=${args[0]}
BUILDDIR="/tmp/ms-$BRANCH-build"
if test -d "$BUILDDIR"; then
	rm -rf "$BUILDDIR"
fi

