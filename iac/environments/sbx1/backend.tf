#########################################################
# Config: remote backend
#
# Need to supply the sensitive values during `terraform init`
# 
# terraform init \
#    -backend-config="access_key=ACCESS_KEY_ID" \
#    -backend-config="secret_key=SECRET_ACCESS_KEY" \
#    -backend-config="bucket=S3_STATE_BUCKET_NAME"
#########################################################
terraform {
  backend "s3" {
    key    = "ccs-scale-shared-paas-infra-sbx1"
    region = "eu-west-2"
  }
}

