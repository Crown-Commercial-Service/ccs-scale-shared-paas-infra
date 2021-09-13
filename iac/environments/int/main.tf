#########################################################
# Environment: INT
#
# Deploy shared resources
#########################################################
locals {
  env_allowed_ips = <<EOT
allow 3.9.61.85/32; # Ent-APIG external (TST/INT)
EOT  
}

module "deploy-all" {
  source           = "../../modules/configs/deploy-all"
  space            = "int"
  environment      = "int"
  cf_username      = var.cf_username
  cf_password      = var.cf_password
  syslog_drain_url = "https://d74f58fc-479f-413d-bb66-1cec772b5f5a-ls.logit.io:17256"
  env_allowed_ips  = local.env_allowed_ips
}
