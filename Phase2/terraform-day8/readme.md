# Day 8 – Multi-Cloud Infrastructure with Terraform

Day 8 marked the beginning of the Terraform phase of this project. The goal was to provision infrastructure on AWS and GCP from a single Terraform codebase while learning how Terraform handles providers, variables, outputs, conditional resources, and state.

## What I Worked On
- Installed and configured Terraform
- Configured AWS IAM credentials and Google Cloud authentication
- Provisioned Ubuntu VMs on AWS and GCP
- Used variables, outputs, and `terraform.tfvars`
- Used conditional `count` logic for multi-cloud deployments
- Added boolean flags to deploy:
  - AWS only
  - GCP only
  - Both clouds together
- Learned how Terraform references counted resources
- Fixed Git issues caused by committing Terraform-generated files

## Challenges Encountered
- GCP OAuth authentication issues inside WSL
- Terraform reference errors after introducing `count`
- Git push failures caused by `.terraform` files and Terraform state

## Key Lessons
- `count` works on resources, but not on providers or outputs
- Resources using `count` must be referenced with indexes
- Terraform state files should never be committed to Git
- Multi-cloud deployments become easier when configuration is parameterized

## Stack
- Terraform
- AWS EC2
- Google Compute Engine
- AWS CLI
- Google Cloud SDK
- Git / GitHub

## Article
Read the full article here:  
[Day 8 – Starting Terraform and Provisioning Multi-Cloud Infrastructure](https://medium.com/@oyawoledamilola01/learning-terraform-the-practical-way-aws-gcp-and-everything-that-went-wrong-deca74f06cab)