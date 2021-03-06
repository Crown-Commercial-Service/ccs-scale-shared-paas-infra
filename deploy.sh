#!/bin/bash
#
# Deploys the CF shared infra
#

echo "Executing Terraform scripts in [$CF_ENVIRONMENT]"
cd ./iac/environments/$CF_ENVIRONMENT/
terraform init -backend-config="bucket=$S3_STATE_BUCKET_NAME" -backend-config="dynamodb_table=$DDB_LOCK_TABLE_NAME"
terraform validate
terraform apply -auto-approve -input=false -var="cf_username=$CF_USERNAME" -var="cf_password=$CF_PASSWORD"
