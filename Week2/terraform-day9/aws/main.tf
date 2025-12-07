
module "aws_instance" {
  source        = "../modules/aws_instance"
  deploy_aws    = var.deploy_aws
  instance_type = var.aws_instance_type
  instance_name = "modular-ec2"
}

