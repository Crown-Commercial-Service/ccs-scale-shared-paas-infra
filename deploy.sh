#!/bin/bash
#
# Deploys the CF infra
#

echo "Executing Terraform apply..."
cd ./tf/environments/sbx1/
terraform init $tf_init_cli_options -backend-config="access_key=$ACCESS_KEY_ID" -backend-config="secret_key=$SECRET_ACCESS_KEY" -backend-config="bucket=$S3_STATE_BUCKET_NAME"
terraform validate $tf_validation_cli_options
#terraform plan $tf_plan_cli_options -var="cf_username=$CF_USERNAME" -var="cf_password=$CF_PASSWORD"
terraform apply $tf_apply_cli_options -var="cf_username=$CF_USERNAME" -var="cf_password=$CF_PASSWORD"
