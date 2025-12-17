
module "gcp_instance" {
  source       = "../modules/gcp_instance"
  deploy_gcp   = var.deploy_gcp
  vm_name      = "modular-gcp"
  gcp_machine_type = var.gcp_machine_type
  gcp_image        = var.gcp_image
}