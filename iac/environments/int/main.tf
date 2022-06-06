#########################################################
# Environment: INT
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source      = "../../modules/configs/deploy-all"
  space       = "int"
  environment = "int"
  cf_username = var.cf_username
  cf_password = var.cf_password
}
