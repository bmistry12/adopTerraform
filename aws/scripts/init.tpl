#!/bin/bash

sleep 30

## Getting the UserData Script from Git
curl -L https://gist.githubusercontent.com/bmistry12/6a4296de580f69158f864546ee6ecb6d/raw/ADOPC-User-Data.sh > ~/userData.sh
chmod +x ~/userData.sh

## Set Variables
export INITIAL_ADMIN_USER=${adop_username}
export INITIAL_ADMIN_PASSWORD_PLAIN=${adop_password}
export SecretS3BucketStore=${s3_bucket_name}
export KeyName=${key_name}

## Running UserData Script
cd ~/
./userData.sh