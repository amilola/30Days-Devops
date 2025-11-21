#!/bin/bash

REMOTE_USER="ubuntu"
REMOTE_HOST="$1"
KEY_PATH="$HOME/.ssh/devops/devops-key.pem"
PROJECT_PATH="$HOME/30_days/src/Week1/App_deployment/Flask_Nginx"

if [ -z "$REMOTE_HOST" ]; then
    echo "Usage: ./deploy_to_remote.sh <server-ip>"
    exit 1
fi

echo "=======Copying check script to EC2======"
scp -i "$KEY_PATH" system_health_check.sh \
    $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/

echo "======Setting Permission ======"
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "chmod +x system_health_check.sh"

echo "===== Executing Script Remotely ====="
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "sudo ./system_health_check.sh"

echo "==== Copying devtools installation script to EC2 ===="
scp -i "$KEY_PATH" remote_install_devtools.sh \
    $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/

echo "======Setting Permission ======"
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "chmod +x remote_install_devtools.sh"

echo "===== Executing Script Remotely ====="
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST \
    "sudo ./remote_install_devtools.sh"

echo "==== Copying Docker project to server ===="
scp -i "$KEY_PATH" -r "$PROJECT_PATH" \
    $REMOTE_USER@$REMOTE_HOST:/home/$REMOTE_USER/project

echo "==== Deploying Docker Compose on EC2 ===="
ssh -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST "
    cd project
    sudo docker compose down || true
    sudo docker compose build
    sudo docker compose up -d
"
echo "==== Deployment Complete! ===="
echo "Visit http://$REMOTE_HOST" 