#!/bin/bash
## Getting the UserData Script from Git
curl -L https://raw.githubusercontent.com/bmistry12/adopTerraform/master/scripts/userData.sh > ~/userData.sh
chmod +x ~/userData.sh

## Set Variables
export INITAL_ADMIN_USER = ${adop_username}
export INITIAL_ADMIN_PASSWORD_PLAIN=${adop_password}

## Run the userData script
cd ~/
./userData.sh