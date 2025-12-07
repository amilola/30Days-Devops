

variable "gcp_region" {
  default = "us-central1"
}

variable "gcp_zone" {
  default = "us-central1-c"
}

variable "deploy_gcp" {
  type    = bool
  default = true
}

variable "gcp_machine_type" {
  default = "e2-micro"
}

variable "gcp_image" { default = "ubuntu-2404-lts-arm64" }

variable "gcp_project" { default = "daysofdevops" }

