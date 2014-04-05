#!/bin/bash

rsa_key=id_rsa_deploy
rsa_key_b64=id_rsa_deploy_base64

# This is a bashism !
echo -n $id_rsa_{00..35} >> ~/.ssh/$rsa_key_b64
base64 --decode --ignore-garbage ~/.ssh/$rsa_key_b64 > ~/.ssh/$rsa_key
chmod 600 ~/.ssh/$rsa_key

echo "Host github.com" > ~/.ssh/config
echo "    StrictHostKeyChecking no" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/$rsa_key" >> ~/.ssh/config

