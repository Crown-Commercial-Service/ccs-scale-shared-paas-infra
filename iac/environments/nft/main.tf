#########################################################
# Environment: NFT
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source                     = "../../modules/configs/deploy-all"
  space                      = "nft"
  environment                = "nft"
  cf_username                = var.cf_username
  cf_password                = var.cf_password
  agreements_db_service_plan = "medium-ha-12-high-iops"
  ip_router_instances        = 3
  ip_router_memory           = 2048
}
