variable "organisation" {
  default = "ccs-shared-services"
}

variable "space" {}

variable "environment" {}

variable "agreements_db_service_plan" {
  default = "medium-ha-13"
}

variable "agreements_db_create_timeout" {
  default = "30m"
}

variable "agreements_db_delete_timeout" {
  default = "30m"
}

variable "cf_username" {
  sensitive = true
}

variable "cf_password" {
  sensitive = true
}

variable "ip_router_instances" {
  default = 2
}

variable "ip_router_memory" {
  default = 1024
}
