# AWS public IP
output "aws_instance_ip" {
  value       = var.deploy_aws ? aws_instance.app_server[0].public_ip : null
  description = "Public IP of AWS instance"
}

# GCP public IP
output "gcp_instance_ip" {
  value       = var.deploy_gcp ? google_compute_instance.vm[0].network_interface[0].access_config[0].nat_ip : null
  description = "Public IP of GCP instance"
}
