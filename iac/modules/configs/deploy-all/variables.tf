variable "organisation" {
  default = "ccs-shared-services"
}

variable "space" {}

variable "environment" {}

variable "postgres_service_plan" {
  default = "tiny-unencrypted-12-high-iops"
}

variable "cf_username" {
  sensitive = true
}

variable "cf_password" {
  sensitive = true
}

variable "syslog_drain_url" {}

variable "allowed_ips" {
  default = <<EOT
allow 195.59.5.128/29;   # TechOps private range
allow 51.149.9.112/29;   # CCS External VPN
allow 51.149.9.240/29;   # CCS External VPN
allow 146.199.240.40/32; # TB
allow 84.68.181.230/32;  # AM
allow 203.99.209.0/24;   # Cog External VPN
allow 18.133.142.117/32; # Cog 'SCALE Test Machine 3' in NFT
EOT
}
