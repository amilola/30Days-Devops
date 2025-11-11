#!/bin/bash
# system_health_check.sh
# Automated Linux system health monitor with alerts, logging, and color output

LOG_FILE="/var/log/system_health_$(date +%F).log"
THRESHOLD_DISK=80
THRESHOLD_MEM=80

#color codes
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

# Function that saves into a log file and also prints to terminal

log(){
    echo -e "$1" | tee -a "$LOG_FILE"
}

#Function that checks the success of the previous command run

check_command(){
    if [ $? -ne 0 ]; then
      log "${RED}Error running: $1${NC}"
      exit 1
    fi
}

#Header
log "   "
log "=============================="
log "System Health Check"
log "Date: $(date)"
log "==============================="

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
log "\nDisk Usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
  log "${RED}Disk Usage above ${THRESHOLD_DISK}%!${NC}"
else
  log "${GREEN}Disk Usage Within Limits.${NC}"
fi

check_command "Disk usage check"

#Memory Usage

MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
log "\nMemory Usage: ${MEM_USAGE}"
if [ "$MEM_USAGE" -gt "$THRESHOLD_MEM" ]; then
  log "${YELLOW}Memory usage above ${THRESHOLD_MEM}%!${NC}"
else
  log "${GREEN}Memory usage within limits.${NC}"
fi

check_command "Memory usage check"

#CPU load average
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}')
log "\nCPU Load (1-min avg): $LOAD_AVG"

check_command "CPU load check"

#Uptime
log "\nUptime: $(uptime -p)"
check_command "Uptime check"

log "\nHealth Check Completed Successfully"
log "Log saved to $LOG_FILE"

