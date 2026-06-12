#!/bin/bash
# Deploys the main branch HTML build output to the gh-pages branch of the
# MapServer-documentation repo. Called from build.yml when a push to main
# is detected

builddir=$1
sha=$2
github_token=$3

git config user.email "mapserverbot@mapserver.bot"
git config user.name "MapServer deploybot"

git clone --no-checkout --depth=1 \
  https://x-access-token:${github_token}@github.com/mapserver/MapServer-documentation.git \
  /tmp/MapServer-documentation

cd /tmp/MapServer-documentation
git checkout -B gh-pages

# delete existing files
git rm -r * --quiet || true

# add in the new build files
cp -rf "$builddir/html/"* .
touch .nojekyll

git add -A
git commit -m "update with results of commit https://github.com/mapserver/MapServer-documentation/commit/$sha" --quiet || echo "Nothing to commit"
git push origin gh-pages --force