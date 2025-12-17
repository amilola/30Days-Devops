terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "daysofdevops"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_instance" "vm" {
  name         = "day8-vm"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-lts-arm64"
    }
  }

  network_interface {
    network = "default"

    access_config {} # creates public IP
  }
}

output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

