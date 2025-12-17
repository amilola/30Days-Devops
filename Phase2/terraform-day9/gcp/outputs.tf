
output "gcp_ip" {
  value       = var.deploy_gcp ? module.gcp_instance.public_ip : null
  description = "Public IP of GCP Instance"
}
