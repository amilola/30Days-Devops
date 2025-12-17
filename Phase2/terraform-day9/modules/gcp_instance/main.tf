resource "google_compute_instance" "vm" {
  count        = var.deploy_gcp ? 1 : 0
  name         = var.vm_name
  machine_type = var.gcp_machine_type

  boot_disk {
    initialize_params {
      image = var.gcp_image
    }
  }

  network_interface {
    network = "default"

    access_config {} # creates public IP
  }
}
