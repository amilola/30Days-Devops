#!/bin/bash

echo "====== Remote Script Started ======="

echo "Updating System ..."
sudo apt-get update -y

echo "System info:"
uname -a

echo "Current user: $(whoami)"
echo "Home directory: $HOME"

echo "Environment variable TEST_VAR = $TEST_VAR"

echo "======Remote Script Finished ====="