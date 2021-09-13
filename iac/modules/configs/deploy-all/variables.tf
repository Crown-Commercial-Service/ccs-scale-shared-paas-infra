variable "organisation" {
  default = "ccs-shared-services"
}

variable "space" {}

variable "environment" {}

variable "agreements_db_service_plan" {
  default = "small-ha-12"
}

variable "cf_username" {
  sensitive = true
}

variable "cf_password" {
  sensitive = true
}

variable "syslog_drain_url" {}

variable "ip_router_instances" {
  default = 2
}

variable "ip_router_memory" {
  default = 1024
}
