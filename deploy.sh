#!/bin/bash
#
# Deploys the CF shared infra
#

echo "Executing Terraform scripts to build shared space"
cd ./iac/environments/$CF_ENVIRONMENT/
terraform init $tf_init_cli_options -backend-config="access_key=$ACCESS_KEY_ID" -backend-config="secret_key=$SECRET_ACCESS_KEY" -backend-config="bucket=$S3_STATE_BUCKET_NAME"
terraform validate $tf_validation_cli_options
terraform apply -auto-approve -input=false -var="cf_username=$CF_USERNAME" -var="cf_password=$CF_PASSWORD"
