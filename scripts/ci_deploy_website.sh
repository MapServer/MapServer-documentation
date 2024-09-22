#!/bin/bash

builddir=$1
destdir=$2
sha=$3

# check the PDF was created and upload to https://mapserver.org/pdf/MapServer.pdf
if [ -f $builddir/latex/en/MapServer.pdf ]; then
  set -x
  scp $builddir/latex/en/MapServer.pdf mapserver@mapserver.org:/var/www/mapserver.org/pdf/
  set +x
fi

if [ ! -d $destdir/mapserver.github.io ]; then
  git clone git@github.com:mapserver/mapserver.github.io.git $destdir/mapserver.github.io
fi

# remove all previous files in the repo if [build_translations]
# is in the commit message
git log -n1 | grep -q "\\[build_translations\\]"

if [[ $? -eq 0 ]]; then
    rm -rf "$destdir/mapserver.github.io"/*
fi

# copy in the newly created files
cd $builddir/html
cp -rf * $destdir/mapserver.github.io

cd $destdir/mapserver.github.io

# restore README.md from the last commit
git checkout HEAD -- README.md

git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

git add -A
git commit -m "update with results of commit https://github.com/mapserver/MapServer-documentation/commit/$sha"
git push origin master
