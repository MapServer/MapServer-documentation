#!/bin/bash

git log -n1 | grep -q "\\[build_translations\\]"

if [[ $? -eq 0 ]]; then
  echo "building all languages"
  make html
else
  echo "building english only"
  make html BUILD_LANGUAGES=
fi
