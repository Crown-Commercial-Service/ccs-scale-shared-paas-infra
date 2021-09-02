variable "organisation" {
  default = "ccs-shared-services"
}

variable "space" {}

variable "environment" {}

variable "postgres_instance_name" {
  default = "agreements-pg-db"
}

variable "postgres_service_plan" {
  default = "tiny-unencrypted-12-high-iops"
}

variable "cf_username" {
  #sensitive = true
}

variable "cf_password" {
  #sensitive = true
}

variable "syslog_drain_url" {}
