#!/bin/bash

builddir=$1
destdir=$2

if [ -f $builddir/latex/en/MapServer.pdf ]; then
  set -x
  scp $builddir/latex/en/MapServer.pdf mapserver@mapserver.org:/var/www/mapserver.org/pdf/
  set +x
fi


if [ ! -d $destdir/mapserver.github.io ]; then
  git clone git@github.com:mapserver/mapserver.github.io.git $destdir/mapserver.github.io
fi

cd $builddir/html
cp -rf * $destdir/mapserver.github.io

cd $destdir/mapserver.github.io
git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

#rm -rf _sources */_sources
#rm -rf .doctrees */.doctrees */.buildinfo

git add -A
git commit -m "update with results of commit https://github.com/mapserver/MapServer-documentation/commit/$TRAVIS_COMMIT"
git push origin master
