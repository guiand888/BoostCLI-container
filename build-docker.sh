#!/bin/bash
set -a
source config.env
set +a

docker build --build-arg USER="$USER" --build-arg UID="$UID" --build-arg GID="$GID" --build-arg SSH_PUBLIC_KEY="$SSH_PUBLIC_KEY" -t boostcli-container .

