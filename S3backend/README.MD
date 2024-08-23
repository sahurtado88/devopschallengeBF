# Overview

This Terraform module provisions the following resources:

- IAM User: Creates a user in AWS IAM with administrative privileges.
- S3 Bucket: Sets up an S3 bucket to store Terraform state files, with versioning enabled and a bucket policy attached.
- DynamoDB Table: Creates a DynamoDB table for state locking and consistency checks when using Terraform.

# Resources Created

## IAM User

- Resource: aws_iam_user.terraform_user
- Description: This creates an IAM user with the name specified by the iam_user variable.

## IAM Policy Attachment

- Resource: aws_iam_user_policy_attachment.admin_policy_attachment
- Description: Attaches the AdministratorAccess policy to the IAM user, granting full administrative privileges.

## S3 Bucket

- Resource: aws_s3_bucket.terraform_state_bucket
- Description: Creates an S3 bucket to store Terraform state files. The bucket's lifecycle policy prevents accidental deletion.

## S3 Bucket Versioning

- Resource: aws_s3_bucket_versioning.versioning_enable
- Description: Enables versioning on the S3 bucket to maintain versions of state files.

## S3 Bucket Policy

- Resource: aws_s3_bucket_policy.s3_policy
- Description: Attaches a policy to the S3 bucket that allows the IAM user to list and perform actions (get/put) on objects in the bucket.

## DynamoDB Table

- Resource: aws_dynamodb_table.state_lock_table
- Description: Creates a DynamoDB table used for locking Terraform state files to ensure consistency during operations.

# Variables
- iam_user: Name of the IAM user to be created.
- bucket_name: Name of the S3 bucket to be created for storing Terraform state files.
- table_name: Name of the DynamoDB table used for state locking.
- environment: Environment identifier, used in tagging resources.

# Usage Example
Here is an example of how to use this Terraform module in your configuration:

```
module "backend" {
  source      = "./modules/remotebackend"
  iam_user    = var.iam_user
  bucket_name = var.bucket_name
  table_name  = var.table_name
}

```
create a .tfvar to configure the values on the variables according to the needs and environment

In this example:
```
# terraform.tfvars
environment = "dev"
iam_user    = "terraform-dev"
bucket_name = "sterraform-remote-backend-s3-sahr2024-dev"
table_name  = "terraform_state_locks-dev"
region      = "us-east-1"
```

The IAM user terraform is created.
An S3 bucket named sterraform-remote-backend-s3-sahr2024 is provisioned to store the Terraform state files.
A DynamoDB table named terraform_state_locks is created for state locking in the region us-east-1 .

# How to Apply the Module

## Initialize the Terraform Working Directory:

Navigate to your Terraform project directory and run:
```
terraform init
```

## Plan the Terraform Deployment:

Review the changes that Terraform will make to your infrastructure by running terraform plan in this case we use terraform.tfvars to use these variables in case you create another file change the name of the file in the command:
```
terraform plan --var-file terraform.tfvars
```
## Apply the Terraform Configuration:

Execute the plan and deploy the resources by running terraform apply --var-file namefile.tfvars in this case we use terraform.tfvars to use these variables in case you create another file change the name of the file in the command::
```
terraform apply --var-file terraform.tfvars -auto-approve
```

## Manage the State:

After the resources are created, Terraform will store its state file in the S3 bucket created by this module. The DynamoDB table will be used to lock the state during operations to ensure no concurrent modifications occur.

# Notes
## Resource Deletion Protection:

Both the S3 bucket and DynamoDB table have prevent_destroy lifecycle rules enabled to prevent accidental deletion. To delete these resources, you must first remove the prevent_destroy attribute from the configuration.

## AWS Credentials:

Ensure that the AWS credentials configured in your environment have the necessary permissions to create IAM users, S3 buckets, and DynamoDB tables.

This module is essential for managing Terraform state files securely and ensuring consistency during Terraform operations by using AWS best practices.