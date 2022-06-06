#########################################################
# Environment: Production
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source                     = "../../modules/configs/deploy-all"
  space                      = "production"
  environment                = "prd"
  cf_username                = var.cf_username
  cf_password                = var.cf_password
  agreements_db_service_plan = "medium-ha-13-high-iops"
  ip_router_instances        = 3
  ip_router_memory           = 2048
}
