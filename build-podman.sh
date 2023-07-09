#!/bin/bash
set -a
source config.env
set +a

podman build --build-arg USER="$MY_USER" --build-arg UID="$USER_ID" --build-arg GID="$GROUP_ID" --build-arg SSH_PUBLIC_KEY="$SSH_PUBLIC_KEY" -t boostcli-container .

