# Day 10 — Exploring Terraform Provisioners

## Overview

Day 10 was the final part of the Terraform phase and my first time working with provisioners.

Up until this point, Terraform was only responsible for creating infrastructure. This day focused on what happens immediately after a server is created and how Terraform can run additional setup steps automatically.

---

## What I Implemented

- Provisioned cloud infrastructure with Terraform
- Explored Terraform provisioners for the first time
- Used `remote-exec` to run commands on newly created servers
- Connected to instances over SSH from Terraform
- Automated initial server setup tasks

---

## Key Concepts

### Provisioners

Provisioners allow Terraform to execute commands during resource creation or destruction.

Terraform supports:

- `remote-exec`
- `local-exec`
- `file`

---

### `remote-exec`

Runs commands directly on the remote server over SSH.

Example use cases:

- Installing packages
- Updating the server
- Running setup scripts

---

### SSH Configuration

To make `remote-exec` work, Terraform needed:

- SSH user
- Private key
- Public IP address
- Connection block

---

## What I Learned

- Terraform can do more than just create infrastructure
- Provisioners help automate post-deployment tasks
- SSH access and connectivity matter a lot in automation
- Provisioners are useful, but should be used carefully

---

## Article

[Read the full article here](https://medium.com/@oyawoledamilola01/understanding-terraform-provisioners-by-actually-using-them-c779d20fffdd)