#!/bin/bash

export PATH=/usr/local/bin:$PATH

rundate=`date +%Y%m%d-%H%M`
bash /osgeo/mapserver.org/scripts/build_docs.sh /osgeo/mapserver.org/docs-git branch-6-4 /osgeo/mapserver.org/htdocs/ >> /osgeo/mapserver.org/scripts/cron-logs/log-64-$rundate.txt 2>&1
rundate=`date +%Y%m%d-%H%M`
bash /osgeo/mapserver.org/scripts/build_docs.sh /osgeo/mapserver.org/docs-git master /osgeo/mapserver.org/htdocs/en/trunk >> /osgeo/mapserver.org/scripts/cron-logs/log-trunk-$rundate.txt 2>&1
