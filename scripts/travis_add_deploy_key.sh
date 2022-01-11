#!/bin/bash

# This is a bashism !
echo -n $id_rsa_{1..23} >> ~/.ssh/travis_rsa_64
base64 --decode --ignore-garbage ~/.ssh/travis_rsa_64 > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
echo -e "Host *\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

