#########################################################
# Config: deploy-all
#
# This configuration will deploy all components.
#########################################################
module "agreements-database" {
  source                  = "../../agreements-db"
  organisation            = var.organisation
  space                   = var.space
  environment             = var.environment
  postgres_service_plan   = var.agreements_db_service_plan
  postgres_create_timeout = var.agreements_db_create_timeout
  postgres_delete_timeout = var.agreements_db_delete_timeout
  cf_username             = var.cf_username
  cf_password             = var.cf_password
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
  instances    = var.ip_router_instances
  memory       = var.ip_router_memory
}
