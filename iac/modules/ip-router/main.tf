#########################################################
# Routing service for IP auth based on nginx
#########################################################
data "cloudfoundry_domain" "domain" {
  name = "london.cloudapps.digital"
}

data "cloudfoundry_org" "shared" {
  name = var.organisation
}

data "cloudfoundry_space" "space" {
  name = var.space
  org  = data.cloudfoundry_org.shared.id
}

data "archive_file" "nginx" {
  type        = "zip"
  source_dir  = "${path.module}/app"
  output_path = "${path.module}/.build/nginx.zip"
}

resource "cloudfoundry_app" "nginx" {
  buildpack  = "nginx_buildpack"
  disk_quota = var.disk_quota
  environment = {
    ALLOWED_IPS : var.allowed_ips
  }
  health_check_timeout       = var.healthcheck_timeout
  health_check_type          = "http"
  health_check_http_endpoint = "/_route-service-health"
  instances                  = var.instances
  labels                     = {}
  memory                     = var.memory
  name                       = "${var.environment}-ccs-scale-shared-nginx"
  path                       = data.archive_file.nginx.output_path
  source_code_hash           = data.archive_file.nginx.output_base64sha256
  space                      = data.cloudfoundry_space.space.id
  stopped                    = false
  timeout                    = 600
}

resource "cloudfoundry_route" "nginx" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = data.cloudfoundry_space.space.id
  hostname = cloudfoundry_app.nginx.name

  target {
    app  = cloudfoundry_app.nginx.id
    port = 8080
  }
}

resource "cloudfoundry_user_provided_service" "ip_router" {
  name              = "${var.environment}-ccs-scale-shared-ip-router"
  space             = data.cloudfoundry_space.space.id
  route_service_url = "https://${cloudfoundry_app.nginx.name}.${var.region_domain}"
}
