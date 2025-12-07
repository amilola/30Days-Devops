# AWS public IP
output "public_ip" {
  value       = var.deploy_aws ? aws_instance.app_server[0].public_ip : null
  description = "Public IP of AWS instance"
}