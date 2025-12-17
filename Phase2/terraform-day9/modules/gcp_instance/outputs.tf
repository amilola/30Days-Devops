output "public_ip" {
    value = var.deploy_gcp ? google_compute_instance.vm[0].network_interface[0].access_config[0].nat_ip : null
    description = "Public IP of GCP Instance"
}