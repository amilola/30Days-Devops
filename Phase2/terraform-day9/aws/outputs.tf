output "aws_ip" {
  value       = var.deploy_aws ? module.aws_instance.public_ip : null
  description = "Public IP of AWS instance"
}


