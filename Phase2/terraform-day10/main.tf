
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

resource "aws_key_pair" "aws_key" {
  count         = var.deploy_aws ? 1 : 0
  key_name   = "day10-aws-key"
  public_key = file("${path.module}/keys/awskey.pub")
}

resource "aws_security_group" "ssh_access" {
  count         = var.deploy_aws ? 1 : 0
  name = "day10-ssh-access"
  description = "Allow SSH"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  count         = var.deploy_aws ? 1 : 0
  ami           = data.aws_ami.ubuntu[count.index].id
  instance_type = var.aws_instance_type
  key_name      = aws_key_pair.aws_key[count.index].key_name
  vpc_security_group_ids = [aws_security_group.ssh_access[count.index].id]


  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from AWS provisioner!' | sudo tee /tmp/aws.txt",
      "sudo hostnamectl set-hostname aws-provisioned"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/awskey")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "day10-aws"
  }
}

resource "google_compute_network" "vpc" {
  count        = var.deploy_gcp ? 1 : 0
  name = "vpc-network"
}

resource "google_compute_firewall" "allow_ssh" {
  count        = var.deploy_gcp ? 1 : 0
  name    = "allow-ssh"
  network = google_compute_network.vpc[count.index].name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_instance" "vm" {
  count        = var.deploy_gcp ? 1 : 0
  name         = "day10-vm"
  machine_type = var.gcp_machine_type

  depends_on = [
    google_compute_firewall.allow_ssh
  ]

  boot_disk {
    initialize_params {
      image = var.gcp_image
    }
  }

  network_interface {
    network = google_compute_network.vpc[count.index].name

    access_config {} # creates public IP
  }

  metadata = {
    enable-oslogin = "FALSE"
    ssh-keys = <<EOF
ubuntu:${trimspace(file("${path.module}/keys/gcpkey.pub"))}
EOF
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 20",
      "echo 'Hello from GCP provisioner!' | sudo tee /tmp/gcp.txt",
      "sudo hostnamectl set-hostname gcp-provisioned"
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "ubuntu"
      private_key = file("${path.module}/keys/gcpkey")
      timeout     = "2m"  # increases SSH wait time
    }
  }
}

