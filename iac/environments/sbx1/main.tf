#########################################################
# Environment: SBX1
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source                     = "../../modules/configs/deploy-all"
  space                      = "sandbox"
  environment                = "sbx1"
  cf_username                = var.cf_username
  cf_password                = var.cf_password
  ip_router_instances        = 1
  agreements_db_service_plan = "tiny-unencrypted-12-high-iops"
}
