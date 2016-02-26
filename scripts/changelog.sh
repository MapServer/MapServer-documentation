#!/bin/bash

#run from a mapserver git clone, changelog.sh tag1..tag2 , e.g. for changes
# from 6.4.0 to 6.4.1, run
# changelog.sh rel-6-4-0..rel-6-4-1
# output from this script can be appended to the changelogs after having been
# manually filtered of irrelevant commits

tags=$1

SED=sed
uname=`uname`
if [ "$uname" = "Darwin" ]; then
  SED=gsed
fi
git --no-pager  log --no-merges  --pretty=format:'* %s (%an) : `%h <https://github.com/mapserver/mapserver/commit/%H>`__' $tags  | $SED  's!#\([0-9]\+\)! `#\1 <https://github.com/mapserver/mapserver/issues/\1>`__ !g'
