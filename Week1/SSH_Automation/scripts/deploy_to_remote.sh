#!/bin/bash

REMOTE_USER="ubuntu"
REMOTE_HOST="$1"
KEY_PATH="$HOME/.ssh/devops/devops-key.pem"

if [ -z "$REMOTE_HOST" ]; then
    echo "Usage: ./deploy_to_remote.sh <server-ip>"
    exit 1
fi

echo "==== Copying remote script to EC2 ===="
scp -i "$KEY_PATH" scripts/remote_install.sh \
    $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/

echo "======Setting Permission ======"
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "chmod +x remote_install.sh"

echo "===== Executing Script Remotely ====="
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "TEST_VAR='DamiLearningSSH' ./remote_install.sh"