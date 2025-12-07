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
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
