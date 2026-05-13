# Phase 2 – Terraform + Ansible (Multi-Cloud Infrastructure Automation)

This phase focused on moving from manual infrastructure setup to an automated workflow using Terraform and Ansible across AWS and GCP.

The goal was simple at the start: provision infrastructure with Terraform, configure it with Ansible, and gradually remove manual steps in between.

Over time, it evolved into a full workflow that handles:
- Multi-cloud provisioning
- Modular Terraform design
- Remote state management
- Automated configuration with Ansible
- Bootstrapping new machines
- Secret handling with Ansible Vault
- Terraform-to-Ansible orchestration

---

# What This Phase Covers

## Infrastructure Provisioning (Terraform)
- AWS EC2 provisioning
- Google Compute Engine provisioning
- Multi-cloud deployment from one codebase
- Conditional deployments using variables
- Terraform modules for AWS and GCP separation

## Terraform Architecture Improvements
- Breaking infrastructure into reusable modules
- Understanding variable contracts between root and modules
- Using outputs across module boundaries
- Local state testing before remote backends
- Remote state setup:
  - AWS: S3 + DynamoDB locking
  - GCP: GCS backend
- Understanding backend limitations and one-backend-per-root constraint

## Configuration Management (Ansible)
- First integration of Ansible with Terraform
- Static inventory vs dynamic runtime values
- Bootstrap playbook for fresh VM setup
- Main playbook for full configuration
- Understanding SSH behavior and connectivity issues
- Idempotent configuration model

## Terraform + Ansible Integration
- Using `null_resource` as an orchestration hook
- Using `local-exec` to trigger Ansible from Terraform
- Passing Terraform outputs into Ansible via `--extra-vars`
- Controlling execution order using `depends_on`

## Bootstrapping Challenges
- SSH authentication prompts blocking automation
- SSH key trust issues in non-interactive execution
- Cloud-init delays causing SSH timeouts on first apply
- Python not being available on fresh instances
- Separation of bootstrap vs full configuration steps

## Automation Stability Improvements
- Adding SSH readiness checks before Ansible execution
- Avoiding blind delays where possible
- Understanding VM readiness vs VM existence
- Fixing race conditions between provisioning and configuration

## Environment & Execution Issues
- Terraform not using activated Python virtual environments
- Fixing execution by calling Ansible via full venv path
- Understanding PATH resolution in `local-exec`
- Forcing correct Ansible config using `ANSIBLE_CONFIG`

## Security (Ansible Vault)
- Introduction to secret management with Ansible Vault
- Encrypting sensitive variables (`secrets.yaml`)
- Using `vault.pass` as a decryption key file
- Keeping secrets out of Terraform state
- Separating infrastructure, configuration, and secrets

## Git & Workflow Issues
- Preventing Terraform state and plugins from being committed
- Fixing broken Git pushes caused by `.terraform` directory
- Reinforcing separation between code and generated artifacts

---

# Key Concepts Learned

- Terraform is for provisioning, not configuration
- Ansible is for configuration, not infrastructure creation
- Provisioners (`local-exec`) are orchestration tools, not core design
- Infrastructure readiness is not the same as VM availability
- Multi-cloud setups require explicit structure, not assumptions
- Secrets must never pass through Terraform state
- Automation requires removing interactive dependencies (SSH prompts, manual inputs)

---

# Final Architecture

Terraform:
- Creates AWS + GCP infrastructure
- Outputs IP addresses
- Triggers Ansible execution

Ansible:
- Bootstraps fresh machines (Python, dependencies)
- Configures servers (Docker, Nginx, packages)
- Handles idempotent configuration
- Uses encrypted secrets via Vault

Execution Flow:
terraform apply
  ├── provision AWS + GCP
  ├── wait for SSH readiness
  ├── run Ansible bootstrap
  └── run Ansible configuration

---

# Outcome of Phase 2

By the end of this phase:
- Infrastructure is fully reproducible across AWS and GCP
- Manual IP handling was removed
- Configuration became automated
- Secrets are handled securely
- The system runs from a single command

This is not production-grade CI/CD, but it is a structured and working infrastructure automation pipeline built from first principles.

---

# Links to Articles
  
  (https://medium.com/@oyawoledamilola01)