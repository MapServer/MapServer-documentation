#!/bin/bash
# Deploys the main branch HTML build output to the gh-pages branch of the
# MapServer-documentation repo. Called from build.yml when a push to main
# is detected

set -euo pipefail

builddir=$1
sha=$2
github_token=$3

git config --global user.email "mapserverbot@mapserver.bot"
git config --global user.name "MapServer deploybot"

git clone --depth=1 \
  https://x-access-token:${github_token}@github.com/MapServer/MapServer-documentation.git \
  /tmp/MapServer-documentation

cd /tmp/MapServer-documentation
git fetch origin gh-pages
git checkout -B gh-pages origin/gh-pages

# delete existing files
git rm -rf --quiet --ignore-unmatch .


# add in the new build files
cp -a "$builddir/html/." .
touch .nojekyll

git add -A
git commit -m "update with results of commit https://github.com/MapServer/MapServer-documentation/commit/$sha" --quiet || echo "Nothing to commit"
git push origin gh-pages