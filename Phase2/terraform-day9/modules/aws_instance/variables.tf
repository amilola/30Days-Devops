variable "instance_type" {}

variable "instance_name" {}

variable "deploy_aws" {
    description = "Deploy AWS Instance"
    type        = bool
    default     = true
}