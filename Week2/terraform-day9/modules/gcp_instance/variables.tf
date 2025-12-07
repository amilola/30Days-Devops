variable "vm_name" {}

variable "gcp_image" {}

variable "gcp_machine_type" {}

variable "deploy_gcp" {
    description = "Deploy GCP instance"
    type        = bool
    default     = true
}