# Overview

This Terraform project allows you to create a basic AWS infrastructure that includes:

- A VPC with public and private subnets.
- Route tables for each subnet.
- A security group to allow traffic on ports 80 and 443.
- An Elastic Load Balancer (ELB) listening on ports 80 and 443.
- A hosted zone in Route 53 and a CNAME record pointing to the ELB.

The project is designed to be modular, making it easy to create and manage different environments (development, staging, production).


# Prerequisites

Before using these Terraform files, ensure you meet the following prerequisites:

- Terraform: Installed on your local machine. You can install it by following the official Terraform instructions.
- AWS Credentials: Set up your AWS credentials on your local machine using aws configure or environment variables.
- AWS Access: Required permissions to create resources such as VPCs, subnets, ELBs, security groups, and DNS records in Route 53.
- You have created the s3 bucket and the dynamo table to store the tfstate. you can create these resources by following the readme in the S3backend folder
- You need a domain to configure the infrastructure correctly.

## Variable Configuration
Each module and environment has a variables.tf file where you can configure the specific values for your infrastructure.

This project uses the partial configuration of the backend so you can deploy the infrastructure in different environments for this you need to edit or create in the folder state_configuration the values of bucket, key, dynamotable and region where you have your bucket and dynamo.

Example partial configuration in state_configuration/dev-s3-state.hcl
```
bucket = "sterraform-remote-backend-s3-sahr2024-dev"
key = "dev/terraform.tfstate"
dynamodb_table = "terraform_state_locks-dev"
region = "us-east-1"
```
## terraform.tfvars File
This file is used to override Terraform's default variables. You can define common variables here that apply across environment.

this is an example to deploy in dev environment
```
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
environment          = "Dev"
region               = "us-east-1"
domain_name = "dev.com"
subdomain_name="prueba.dev.com"
```

# Usage
## Initialization
Before using the Terraform files, you need to initialize the working directory. you need to add -backend-config option and indicate the path and file that you configure to set the backend

for example
```
terraform init -backend-config="state_configuration/dev-s3-state.hcl"
```
This command downloads the required providers and modules for Terraform and configure the proper backend.

## Planning
The next step is to plan the infrastructure creation. This will show a summary of the resources that will be created running terraform plan.
In this case we use terraform.tfvars to use these variables in case you create another file change the name of the file in the command:
```
terraform plan --var-file dev.tfvars
```

## Applying
To apply the changes and create the infrastructure in AWS, run:
terraform apply --var-file namefile.tfvars in this case we use terraform.tfvars to use these variables in case you create another file change the name of the file in the command:

```
terraform apply --var-file dev.tfvars -auto-approve
```

# Modules

## VPC
This module creates the VPC, public and private subnets, and the associated route tables, also creates internet gateway and nat gateway per subnet.

## SG Security Group
This module creates a security group that allows traffic on ports 80 and 443 from any IP.

## ELB
This module creates an Elastic Load Balancer with listeners on ports 80 and 443.

## Route 53
This module creates a hosted zone in Route 53 and a CNAME record pointing to the ELB.

## ACM
This module create requesting and management oof ceritficates neccesary to configure https

# Troubleshooting
- Permission Errors: Ensure that your AWS credentials have the necessary permissions.

- Naming Conflicts: To avoid conflicts, ensure that resources in different environments have unique names using environment prefixes.

 