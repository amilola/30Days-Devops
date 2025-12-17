
variable "aws_region" {
  default = "eu-north-1"
}

variable "aws_instance_type" {
  default = "t4g.micro"
}

variable "deploy_aws" {
  type    = bool
  default = true
}

