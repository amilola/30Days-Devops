# Cloud selection
variable "deploy_aws" {
  description = "Cloud provider: aws"
  type        = bool
}

variable "deploy_gcp" {
  description = "Cloud provider: gcp"
  type        = bool
}

# AWS variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "aws_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t4g.micro"
}

# GCP variables
variable "gcp_project" {
  description = "GCP project ID"
  type        = string
  default     = "daysofdevops"
}
variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}
variable "gcp_zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-c"
}
variable "gcp_machine_type" {
  description = "GCP machine type"
  type        = string
  default     = "e2-micro"
}
variable "gcp_image" {
  description = "GCP boot disk image"
  type        = string
  default     = "ubuntu-2404-lts-arm64"
}
