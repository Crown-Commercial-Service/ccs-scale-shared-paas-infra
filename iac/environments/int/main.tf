#########################################################
# Environment: INT
#
# Deploy shared resources
#########################################################
module "deploy-all" {
  source           = "../../modules/configs/deploy-all"
  space            = "int"
  environment      = "int"
  cf_username      = var.cf_username
  cf_password      = var.cf_password
  syslog_drain_url = "https://d74f58fc-479f-413d-bb66-1cec772b5f5a-ls.logit.io:17256"
}
