
provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

data "aws_ami" "ubuntu" {

  count       = var.deploy_aws ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  count         = var.deploy_aws ? 1 : 0
  ami           = data.aws_ami.ubuntu[count.index].id
  instance_type = var.aws_instance_type

  tags = {
    Name = "learn-terraform"
  }
}

resource "google_compute_instance" "vm" {
  count        = var.deploy_gcp ? 1 : 0
  name         = "day8-vm"
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

