# Day 13 — Managing Secrets with Ansible Vault

## Overview

Day 13 focused on handling secrets properly using Ansible Vault.

Even though I was not working with real production secrets yet, I wanted the workflow to reflect how secrets are managed in real environments.

---

## What I Implemented

- Created an encrypted `secrets.yaml`
- Used `ansible-vault encrypt`
- Stored the vault password separately in `vault.pass`
- Referenced encrypted variables from `group_vars`
- Kept Terraform completely unaware of secrets

---

## Key Concepts

### `secrets.yaml`

Contains encrypted variables and can safely exist inside the repository.

### `vault.pass`

Contains the password used to decrypt vault files and should never be committed to Git.

### Ansible Vault

Decrypts secrets only at runtime during playbook execution.

---

## Separation of Responsibilities

- Terraform provisions infrastructure
- Ansible configures servers
- Vault protects sensitive values

Terraform only handles infrastructure and IP addresses. Secrets remain inside Ansible.

---

## Additional Topic

I also explored Terraform teardown behavior and learned why:

```bash
terraform apply
terraform destroy
```

are intentionally separate commands.

Terraform requires explicit intent before destroying infrastructure.

---

## What I Learned

- Secret management should stay outside Terraform state
- Encryption and password management are separate concerns
- Ansible Vault fits naturally into configuration workflows

---

## Article

[Read the full article here](https://medium.com/@oyawoledamilola01/removing-the-gaps-between-provisioning-and-configuration-abeb989594d1)