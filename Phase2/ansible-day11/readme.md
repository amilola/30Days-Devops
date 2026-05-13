# Day 11 — Getting Started with Ansible

## Overview

Day 11 marked the beginning of the Ansible phase of the project.

After spending time provisioning infrastructure with Terraform, the focus shifted to configuration management and automation using Ansible.

The goal was to configure multiple servers consistently without manually SSHing into each one.

---

## What I Implemented

- Installed and configured Ansible
- Created an inventory file for AWS and GCP servers
- Connected to remote servers using SSH keys
- Tested connectivity using Ansible ping
- Created playbooks for server configuration
- Automated package installation and setup tasks

---

## Key Concepts

### Inventory

The inventory file tells Ansible which servers to manage.

It can contain:

- Hosts
- Groups
- Variables

---

### Playbooks

Playbooks are YAML files that define automation tasks.

Examples:

- Install packages
- Start services
- Clone repositories

---

### Idempotency

One of the main ideas behind Ansible.

Running the same playbook multiple times should not create duplicate changes or break the server state.

---

## Issues Encountered

### SSH Authentication Problems

Ansible could not connect until the correct SSH keys and permissions were configured properly.

---

### Python Dependency

Some fresh servers did not have Python installed, which caused Ansible modules to fail.

This later became important during the Terraform + Ansible integration phase.

---

## What I Learned

- Ansible focuses on configuration, not provisioning
- YAML structure matters a lot in playbooks
- Inventory organization becomes important quickly
- Automation is much easier when tasks are repeatable and idempotent

---

## Article

[Read the full article here](https://medium.com/@oyawoledamilola01/getting-comfortable-with-ansible-and-why-it-took-longer-than-i-expected-fa76d4913e86)