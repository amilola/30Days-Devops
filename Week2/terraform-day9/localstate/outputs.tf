output "aws_ip" {
  value       = var.deploy_aws ? module.aws_instance.public_ip : null
  description = "Public IP of AWS instance"
}

output "gcp_ip" {
  value       = var.deploy_gcp ? module.gcp_instance.public_ip : null
  description = "Public IP of GCP Instance"
}
