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
  syslog_drain_url           = "https://204572d5-f8ba-45f1-9e81-55e89762f616-ls.logit.io:12111"
  agreements_db_service_plan = "medium-ha-12-high-iops"
  ip_router_instances        = 3
  ip_router_memory           = 2048
}
