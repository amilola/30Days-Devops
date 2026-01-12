
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

resource "aws_key_pair" "ansiblekey" {
  count       = var.deploy_aws ? 1 : 0

  key_name = "ansible-key"
  public_key = file("keys/awskey.pub")
}

resource "aws_security_group" "ssh_sg" {
  count         = var.deploy_aws ? 1 : 0
  name        = "ssh-access"
  description = "Allow SSH"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "app_server" {
  count         = var.deploy_aws ? 1 : 0
  ami           = data.aws_ami.ubuntu[count.index].id
  instance_type = var.aws_instance_type
  key_name = aws_key_pair.ansiblekey[count.index].key_name
  vpc_security_group_ids = [
    aws_security_group.ssh_sg[count.index].id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "learn-terraform"
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
  name         = "day8-vm"
  machine_type = var.gcp_machine_type

  boot_disk {
    initialize_params {
      image = var.gcp_image
    }
  }

  network_interface {
    network = google_compute_network.vpc[count.index].name

    access_config {} # creates public IP
  }

  metadata_startup_script = <<EOF
#!/bin/bash
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
chmod 440 /etc/sudoers.d/ubuntu
EOF


  metadata = {
    enable-oslogin = "FALSE"
    ssh-keys = <<EOF
ubuntu:${trimspace(file("${path.module}/keys/gcpkey.pub"))}
EOF
  }

}

resource "null_resource" "wait_for_ssh" {
  depends_on = [
    aws_instance.app_server,
    google_compute_instance.vm
  ]

  provisioner "local-exec" {
    command = <<EOT
echo "Waiting for SSH on AWS..."
until ssh -o StrictHostKeyChecking=no \
          -o UserKnownHostsFile=/dev/null \
          -o ConnectTimeout=5 \
          -i ../ansible/keys/awskey \
          ubuntu@${aws_instance.app_server[0].public_ip} true; do
  sleep 5
done

echo "Waiting for SSH on GCP..."
until ssh -o StrictHostKeyChecking=no \
          -o UserKnownHostsFile=/dev/null \
          -o ConnectTimeout=5 \
          -i ../ansible/keys/gcpkey \
          ubuntu@${google_compute_instance.vm[0].network_interface[0].access_config[0].nat_ip} true; do
  sleep 5
done
EOT
  }
}


resource "null_resource" "ansiblebootstrap" {
  depends_on = [
    null_resource.wait_for_ssh
    ]

  provisioner "local-exec" {
    command = <<EOT
ANSIBLE_CONFIG=../ansible/ansible.cfg ../ansible/ansible-venv/bin/ansible-playbook \
  -i ../ansible/inventory \
  ../ansible/playbooks/bootstrap.yaml \
  --extra-vars 'aws_ip=${aws_instance.app_server[0].public_ip} gcp_ip=${google_compute_instance.vm[0].network_interface[0].access_config[0].nat_ip}'
EOT
  }
}

resource "null_resource" "ansibleconfig" {
  depends_on = [
    null_resource.ansiblebootstrap
  ]

  provisioner "local-exec" {
    command = <<EOT
ANSIBLE_CONFIG=../ansible/ansible.cfg ../ansible/ansible-venv/bin/ansible-playbook \
  -i ../ansible/inventory \
  ../ansible/playbooks/server.yml \
  --extra-vars 'aws_ip=${aws_instance.app_server[0].public_ip} gcp_ip=${google_compute_instance.vm[0].network_interface[0].access_config[0].nat_ip}'
EOT
  }
}

