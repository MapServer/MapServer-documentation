#!/bin/sh
# -*- coding: utf-8 -*-
###############################################################################
# $Id$
#
#  Project:  GDAL
#  Purpose:  (Interactive) script to identify and fix typos
#  Author:   Even Rouault <even.rouault at spatialys.com>
#  Usage:    (run in docs root) ./scripts/fix_typos.sh
#
###############################################################################
#  Copyright (c) 2016, Even Rouault <even.rouault at spatialys.com>
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  the rights to use, copy, modify, merge, publish, distribute, sublicense,
#  and/or sell copies of the Software, and to permit persons to whom the
#  Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included
#  in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
###############################################################################

if ! test -d fix_typos; then
    # Get our fork of codespell that adds --words-white-list and full filename support for -S option
    mkdir fix_typos
    cd fix_typos
    git clone https://github.com/rouault/codespell
    cd codespell
    git checkout gdal_improvements
    cd ..
    # Aggregate base dictionary + QGIS one + Debian Lintian one
    curl https://raw.githubusercontent.com/qgis/QGIS/master/scripts/spelling.dat | sed "s/:/->/" | grep -v "colour->" | grep -v "colours->" > qgis.txt
    curl https://anonscm.debian.org/cgit/lintian/lintian.git/plain/data/spelling/corrections| grep "||" | grep -v "#" | sed "s/||/->/" > debian.txt
    cat codespell/data/dictionary.txt qgis.txt debian.txt | awk 'NF' | grep -v 404 > global_dict.txt
    cd ..
fi

WORDS_WHITE_LIST="slippy,unselectAll,COMMITERS,xwindows"
EXCLUDED_FILES="typos_whitelist.txt,en/howto/Ubuntu_Compilation.txt"

python3 fix_typos/codespell/codespell.py -w -i 3 -q 2 -S $EXCLUDED_FILES \
    -x scripts/typos_whitelist.txt --words-white-list=$WORDS_WHITE_LIST \
    -D fix_typos/global_dict.txt en
