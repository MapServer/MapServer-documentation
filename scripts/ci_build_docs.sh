#!/bin/bash

git log -n1 | grep -q "\\[build_pdf\\]"

if [[ $? -eq 0 ]]; then
  echo "building PDF"
  sudo apt-get update && sudo apt-get install texlive-latex-extra texlive-fonts-recommended
  mkdir -p build/latex/en/
  mv newfloat.sty build/latex/en/
  mv iftex.sty build/latex/en/
  make all-pdf
fi

git log -n1 | grep -q "\\[build_translations\\]"

if [[ $? -eq 0 ]]; then
  echo "building all languages"
  sudo apt-get update && sudo apt-get install gettext
  make clean
  make html
else
  echo "building english only"
  make clean
  make html BUILD_LANGUAGES=
fi

