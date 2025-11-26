#Week 1 — Automate Everything (Linux + Bash + Docker)

This week, I worked on automating the deployment of a Dockerized Flask app to a remote Ubuntu server using Bash and Git. The goal was to go from manual setup to one-command automation.

##What I built

**Automated installation scripts:** Install Docker, Git, and Nginx on any Ubuntu server.

**Dockerized Flask app:** Built locally and ran with Docker, then added Nginx as a reverse proxy.

**SSH automation:** Scripts to copy and run installation and deployment scripts on a remote server.

**Complete workflow:** From local containerization to remote deployment, all automated with Bash.

##Daily progress

**Day 1:** Refreshed Linux essentials, created scripts to check system health (disk, memory, uptime).

**Day 2:** Learned Bash scripting best practices: variables, loops, conditionals, logging, and error handling. Automated installation of dev tools.

**Day 3:** Containerized a Flask web app using Docker.

**Day 4:** Set up multi-container deployment with Docker Compose, including Nginx as a reverse proxy and health checks for the app.

**Day 5:** Automated remote execution with scp and ssh, including passing environment variables.

**Day 6:** Combined everything. My Bash scripts now connects to a remote Ubuntu server, installs Docker and Git if needed, builds the app container, and starts Nginx as a reverse proxy.

##Final folder structure

App deployment/
├── Flask_Nginx
│   ├── app
│   │   ├── Dockerfile
│   │   ├── app.py
│   │   └── requirements.txt
│   ├── docker-compose.yml
│   └── nginx
│       └── default.conf
└── SSH_Automation
    ├── deploy_to_remote.sh
    ├── remote_install_devtools.sh
    └── system_health_check.sh

This repo demonstrates how I automated app deployment from my local machine to a remote server using Bash, Docker, and SSH.