#########################################################
# Logging: logit.io
#
# This will configure a log drain service to logit.io.
#########################################################
data "cloudfoundry_org" "shared" {
  name = var.organisation
}

data "cloudfoundry_space" "cloudfoundry_space" {
  name = var.space
  org  = data.cloudfoundry_org.shared.id
}

data "aws_ssm_parameter" "env_syslog_drain_url" {
  name = "/cat/${var.environment}/syslog-drain-url"
}

resource "cloudfoundry_user_provided_service" "logit_service_broker_service" {
  name             = "${var.environment}-ccs-scale-shared-${var.logit_service_broker_name}"
  space            = data.cloudfoundry_space.cloudfoundry_space.id
  syslog_drain_url = data.aws_ssm_parameter.env_syslog_drain_url.value
}
