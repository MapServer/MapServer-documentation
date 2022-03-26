#!/bin/bash

builddir=$1
destdir=$2

git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

# clone without any existing files
git clone --no-checkout --depth=1 git@github.com:mapserver/MapServer-documentation.git $destdir/MapServer-documentation

cd $destdir/MapServer-documentation
git checkout -B gh-pages

# delete existing files
git rm -r * --quiet

# add in the new build files
cp -rf "$builddir/html/"* $destdir/MapServer-documentation

cd $destdir/MapServer-documentation
touch .nojekyll

git add -A
git commit -m "update with results of commit https://github.com/mapserver/MapServer-documentation/commit/$TRAVIS_COMMIT" --quiet
git push origin gh-pages --force
