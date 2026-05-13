# Day 9 — Terraform Modules and Remote State

## Overview

Day 9 focused on organizing Terraform projects properly using modules and remote state.

Up to this point, everything lived in one place with local state. It worked, but it became harder to manage as the project grew. The goal was to separate AWS and GCP into reusable modules and move state management outside my local machine.

---

## What I Implemented

- Split AWS and GCP resources into separate Terraform modules
- Passed configuration into modules using variables
- Used outputs to expose module values to the root module
- Tested the modular setup locally first
- Configured remote state storage:
  - AWS → S3 + DynamoDB locking
  - GCP → GCS backend

---

## Key Concepts

### Terraform Modules

Modules help organize Terraform code into reusable components.

Instead of repeating infrastructure definitions, resources can be grouped into smaller reusable units.

---

### Terraform State

Terraform stores infrastructure information inside a state file.

The state tracks:
- Existing resources
- Infrastructure changes
- Resource relationships

---

### Remote State

State can be stored remotely instead of locally.

Benefits:
- Better collaboration
- Safer state management
- Reduced risk of state loss

---



## What I Learned

- Modules improve project structure and reusability
- Terraform state management becomes critical quickly
- Remote state introduces operational considerations
- Terraform behaves more predictably once its boundaries are understood

---

## Article

[Read the full article here](https://medium.com/@oyawoledamilola01/terraform-modules-remote-state-and-why-nothing-worked-at-first-85faa3b26b86)