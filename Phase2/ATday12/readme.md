# Day 12 — Connecting Terraform and Ansible

## Overview

Day 12 focused on removing the manual steps between Terraform provisioning and Ansible configuration.

Before this:

```bash
terraform apply
# copy IPs manually
# update inventory
ansible-playbook
```

The goal was to make everything run as one flow.

Terraform provisions the infrastructure, then automatically triggers Ansible using `local-exec` and `null_resource`.

---

## What I Implemented

- Provisioned AWS and GCP instances with Terraform
- Triggered Ansible automatically from Terraform
- Controlled execution order using `depends_on`
- Separated bootstrap and main configuration playbooks
- Passed IPs using `--extra-vars`
- Kept the Ansible inventory static

---

## Key Concepts

### `null_resource`

A Terraform resource that does not create infrastructure but can run provisioners or manage dependencies.

### `local-exec`

Runs commands locally on the machine executing Terraform.

### Bootstrap Playbook

Used to install Python and prepare fresh VMs before the main Ansible playbook runs.

---



## What I Learned

- Terraform and Ansible solve different problems
- Automation exposes issues manual execution hides
- VM creation does not always mean SSH readiness
- Environment and execution context matter a lot in automation

---

## Article

[Read the full article here](https://medium.com/@oyawoledamilola01/removing-the-gaps-between-provisioning-and-configuration-abeb989594d1)