#!/bin/bash

builddir=$1
destdir=$2

if [ ! -d $destdir/mapserver.github.io ]; then
  git clone git@github.com:mapserver/mapserver.github.io.git $destdir/mapserver.github.io
fi
cp -rf $builddir/* $destdir/mapserver.github.io

cd $destdir/mapserver.github.io
git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

rm -rf _sources */_sources

git add -A
git commit -m "update with results of commit https://github.com/mapserver/docs/commit/$TRAVIS_COMMIT"
git push origin master
