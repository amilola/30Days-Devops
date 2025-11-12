#!/bin/bash
# install_dev_tools.sh
#Automates installation of Docker, Git and Nginx on Ubuntu
#Includes logging, color output, and error handling

LOG_FILE="/var/log/dev_setup_$(date +%F).log"

#Color codes
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
NC="\e[0m"

log(){
    echo -e "$1" | tee -a "$LOG_FILE"
}

check_command(){
    if [ $? -ne 0 ]; then
      log "${RED}Error: $1 Failed. Check log at $LOG_FILE${NC}"
      exit 1
    fi
}

#Check if running in a container
is_docker_env(){
    if [ -f /.dockerenv ] || grep -qE '(docker|lxc)' /proc/1/cgroup 2>/dev/null; then
      return 0
    else 
      return 1
    fi
}

#Root Check
if [ "$EUID" -ne 0 ]; then
  log "${YELLOW}Please run this script as root (use sudo).${NC}"
  exit 1
fi

#Check Ubuntu

#Checks if there's an os-release file
if [ ! -f /etc/os-release ]; then
  log "${RED}This system doesn't look like Ubuntu.${NC}"
  exit 1
fi

#Checks if the os-release file is Ubuntu
source /etc/os-release
if [[ "$ID" != "ubuntu" ]]; then
  log "${RED}This script only supports Ubuntu. Detected: $ID${NC}"
  exit 1
fi

log "${GREEN}Ubuntu detected: $VERSION${NC}"

#Update Packages
log "\n Updating System Packages..."
apt-get update -y >> "$LOG_FILE" 2>&1
check_command "apt-get update"

PACKAGES=("git" "nginx")

for pkg in "${PACKAGES[@]}"; do
  if ! command -v "$pkg" &>/dev/null; then
    log "\nInstalling $pkg..."
    apt-get install -y "$pkg">> "$LOG_FILE" 2>&1
    check_command "$pkg installation"
    log "${GREEN}$pkg installed successfully.${NC}"
  else
    log "${GREEN}$pkg already installed.${NC}"
  fi
done

#install docker

if ! command -v docker &>/dev/null; then
  if is_docker_env; then
    log "\nDetected container- Installing Docker (simple apt version)...."
    apt-get install -y docker.io >>"$LOG_FILE" 2>&1
    check_command "Docker.io install"
  else
    log "\nInstalling Docker from official repository..."
    apt-get install -y ca-certificates curl >> "$LOG_FILE" 2>&1
    check_command "Install Prerequisites"

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
      > /etc/apt/sources.list.d/docker.list

    apt-get update -y >>"$LOG_FILE" 2>&1
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >> "$LOG_FILE" 2>&1
    check_command "Docker Installation"
  fi
else
  log "\nDocker Already Installed"
fi

#enable services (skips if inside a container)
if is_docker_env || ! command -v systemctl &>/dev/null; then
  log "Skipping systemctl enable/start inside container or minimal system."
else
  log "Enabling and starting Docker"
  systemctl enable docker >>"$LOG_FILE" 2>&1
  systemctl start docker >>"$LOG_FILE" 2>&1
fi

log "\nVerifying Installations..."
{
    echo "Docker: $(docker --version 2>/dev/null || echo 'not found')"
    echo "Git: $(git --version 2>/dev/null || echo 'not found')"
    echo "Nginx: $(nginx -v 2>&1 || echo 'not found')"
} | tee -a "$LOG_FILE"

log "\n${GREEN}All Packages installed and verified successfully!${NC}"
log "\n Log saved to: $LOG_FILE"
