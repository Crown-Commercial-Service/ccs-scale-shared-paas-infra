#########################################################
# Environment: NFT
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source           = "../../modules/configs/deploy-all"
  space            = "nft"
  environment      = "nft"
  cf_username      = var.cf_username
  cf_password      = var.cf_password
  # This is logit.io DEV stack - update to NFT after it is created (zendesk 28070)
  syslog_drain_url = "https://44f18302-59ca-4034-a82e-63f742e60a3e-ls.logit.io:12732"
}