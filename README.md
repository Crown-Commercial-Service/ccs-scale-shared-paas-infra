# ccs-scale-shared-paas-infra

## Bootstrap the Space

Some commands first need to be run to create the S3 bucket that will subsequently be used to hold Terraform state files remotely. This is a one time task to be done in a new space prior to provisioning the infrastructure.

1. Run script at `/boostrap/create-tf-state=bucket.sh` in the `management` space - this will create an S3 bucket and service key that will be used by all non-prod spaces.

2. View the AWS credentials to access the bucket using the command `cf service-key terraform-state terraform-state-key`. 

3. These credentials will need to be supplied during the `terraform init` operation to setup the backend. `cd` to the `terraform/environments/{env}` folder corresponding to the environment you are provisioning, and execute the following command to initialise the backend:

```
terraform init \
   -backend-config="access_key=AWS_ACCESS_KEY_ID" \
   -backend-config="secret_key=AWS_SECRET_ACCESS_KEY" \
   -backend-config="{bucket=S3_STATE_BUCKET_NAME}" \
```

Note: some static/non-sensitive options are supplied in the `backend.tf` file. Any sensitive config supplied via command line only (this may change in the future if we can use Vault or similar).

This will ensure all Terraform state is now stored in the S3 bucket provisioned in the space you are working in. There is no DynamoDB lock table, but it is unlikely we would be running scripts concurrently in the same space.

## Provision the service infrastructure via Travis

The main environments are provisioned automatically via Travis CI. Merges to key branches will trigger an automatic deployment to certain environments - mapped below:

* `develop` branch -> `development` space
* `main` branch -> `INT` space
* other environments TBD (these mappings may change as we evolve the process as more environments come online)
* feature branches can be deployed to specific sandboxes by making minor changes in the `travis.yml` file (follow instructions)
## Provision the service infrastructure from a local machine

We use Terraform to provision the underlying service infrastructure in a space. We will need to supply the Cloud Foundry login credentials for the user who will provision the infrastructure (Note: it may be better to create a special account for this).

These credentials can be supplied in one of 3 ways:

* via a `secret.tfvars` file, e.g.  `terraform apply -var-file="secret.tfvars"` (this file should not be committed to Git)
* via input variables in the terminal, e.g. `terraform apply -var="cf_username=USERNAME" -var="cf_password=PASSWORD"`
* via environment variables, e.g. `$ export TF_VAR_cf_username=USERNAME`

Assume one of these approaches is used in the commands below (TBD)

1. Run `terraform plan` to confirm the changes look ok
2. Run `terraform apply` to provision the resources

## Populate the database

The Terraform scripts will provision an empty Agreements Database. We need to create the tables and populate with data. 

Prerequisite - install conduit on your local machine (see https://docs.cloud.service.gov.uk/deploying_services/postgresql/#connect-to-a-postgresql-service-from-your-app for details)

The scripts are located here: https://github.com/Crown-Commercial-Service/ccs-scale-db-scripts/blob/develop/agreements. Check this repository out and `cd` to the agreements folder 

2. Create the tables `cf conduit {env}-agreements-pg-db -- psql < ddl.sql`

3. Populate the data - there are a number of scripts to run, documented in the `provision-agreements-database.sh` file - use the same command as above, working down the list of files (note: can copy/paste these into a terminal and it will work through them - need to update {env} first of course)

```
cf conduit {env}-agreements-pg-db -- psql < create_commercial_agreements.sql
cf conduit {env}-agreements-pg-db -- psql < create_lots.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_rules.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_related_lots.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_rule_attributes.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_rule_transaction_objects.sql
cf conduit {env}-agreements-pg-db -- psql < create_commercial_agreement_contacts.sql
cf conduit {env}-agreements-pg-db -- psql < create_sectors.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_sectors.sql
cf conduit {env}-agreements-pg-db -- psql < create_route_to_market.sql
cf conduit {env}-agreements-pg-db -- psql < create_lot_route_to_market.sql
```
