#########################################################
# Config: deploy-all
#
# This configuration will deploy all components.
#########################################################
module "agreements-database" {
  source                 = "../../agreements-db"
  organisation           = var.organisation
  space                  = var.space
  environment            = var.environment
  postgres_service_plan  = var.postgres_service_plan
  cf_username            = var.cf_username
  cf_password            = var.cf_password
}

module "logit-ups" {
  source           = "../../logit-ups"
  organisation     = var.organisation
  space            = var.space
  environment      = var.environment
  syslog_drain_url = var.syslog_drain_url
  cf_username      = var.cf_username
  cf_password      = var.cf_password
}

module "ip-router" {
  source       = "../../ip-router"
  organisation = var.organisation
  space        = var.space
  environment  = var.environment
  allowed_ips  = var.allowed_ips
}
