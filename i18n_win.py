#! /usr/bin/env python
# -*- coding: iso-8859-1 -*-

import os
import sys
import glob
# Add path to be able to append msgfmt as a module
i18n_utils_path = os.path.join(os.path.dirname(sys.executable), "Tools", "i18n")
sys.path.append(i18n_utils_path)
import msgfmt

from optparse import OptionParser

def main():
    parser = OptionParser(usage="usage: %prog [options]",
                          version="%prog 1.0")
    parser.add_option("-l", "--lang",
                      action="store", # optional because action defaults to "store"
                      dest="lang",
                      help="Choose a language for compiling *.po files to *.mo",)
    (options, args) = parser.parse_args()

    if len(args) != 0:
        parser.error("wrong number of arguments, you only have to use lang option")

    os.chdir(os.path.join(os.getcwd(), "translated", options.lang))
    for filename in glob.glob("*.po"):
        msgfmt.make(filename, os.path.join("LC_MESSAGES", filename.split(".")[0] + ".mo"))


if __name__ == '__main__':
    main()

