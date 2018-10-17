#!/bin/bash

sleep 30

## Getting the UserData Script from Git
curl -L https://raw.githubusercontent.com/bmistry12/adopTerraform/master/scripts/userData.sh > ~/userData.sh
chmod +x ~/userData.sh

## Set Variables
export INITIAL_ADMIN_USER=${adop_username}
export INITIAL_ADMIN_PASSWORD_PLAIN=${adop_password}
export SecretS3BucketStore=${s3_bucket_name}
export KeyName=${key_name}

## Running UserData Script
cd ~/
./userData.sh