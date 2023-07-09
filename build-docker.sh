#!/bin/bash
set -a
source config.env
set +a

docker build --build-arg MY_USER="$MY_USER" --build-arg USER_ID="$USER_ID" --build-arg GROUP_ID="$GROUP_ID" --build-arg SSH_PUBLIC_KEY="$SSH_PUBLIC_KEY" -t boostcli-container .

