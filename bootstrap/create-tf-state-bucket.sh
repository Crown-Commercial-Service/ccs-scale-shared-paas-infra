#!/bin/bash

export SERVICE_NAME=terraform-state
export KEY_NAME=terraform-state-key

#######################
# Create Terraform State S3 Bucket
# Requires CF CLI login to target org/space
#######################
cf create-service aws-s3-bucket default $SERVICE_NAME -c '{"public_bucket":false}'

cf create-service-key $SERVICE_NAME $KEY_NAME -c '{"allow_external_access": true}'
