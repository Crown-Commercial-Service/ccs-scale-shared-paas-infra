#########################################################
# Environment: DEV
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source           = "../../modules/configs/deploy-all"
  space            = "development"
  environment      = "dev"
  cf_username      = var.cf_username
  cf_password      = var.cf_password
}
