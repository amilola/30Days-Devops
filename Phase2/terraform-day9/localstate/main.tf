provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "aws" {
  region = var.aws_region
}

module "aws_instance" {
  source        = "../modules/aws_instance"
  deploy_aws    = var.deploy_aws
  instance_type = var.aws_instance_type
  instance_name = "modular-ec2"
}

module "gcp_instance" {
  source       = "../modules/gcp_instance"
  deploy_gcp   = var.deploy_gcp
  vm_name      = "modular-gcp"
  gcp_machine_type = var.gcp_machine_type
  gcp_image        = var.gcp_image
}