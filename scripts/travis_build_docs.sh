#!/bin/bash

git log -n1 | grep -q "\\[build_pdf\\]"

if [[ $? -eq 0 ]]; then
  echo "building PDF"
  sudo apt-get update && sudo apt-get install texlive-latex-extra texlive-fonts-recommended
  # handle missing latex style files 'newfloat.sty' & 'iftex.sty' in precise packages
  wget http://math.sut.ac.th/lab/software/texlive/texmf-dist/tex/latex/caption/newfloat.sty
  wget http://math.sut.ac.th/lab/software/texlive/texmf-dist/tex/generic/iftex/iftex.sty
  mkdir -p build/latex/en/
  mv newfloat.sty build/latex/en/
  mv iftex.sty build/latex/en/
  make all-pdf
fi

git log -n1 | grep -q "\\[build_translations\\]"

if [[ $? -eq 0 ]]; then
  echo "building all languages"
  make html
else
  echo "building english only"
  make html BUILD_LANGUAGES=
fi

