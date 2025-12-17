terraform {
  backend "s3" {
    bucket         = "my-devops-tfstate-bucket--eun1-az1--x-s3"
    key            = "aws/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
