# Description
This Bash script automates the process of listing all resources in an AWS account across multiple regions. It currently supports fetching resources for the following AWS services:

EC2 (Elastic Compute Cloud)
RDS (Relational Database Service)
S3 (Simple Storage Service)
CloudFront
VPC (Virtual Private Cloud)
IAM (Identity and Access Management)
Route53
CloudWatch
CloudFormation
Lambda
SNS (Simple Notification Service)
SQS (Simple Queue Service)
DynamoDB
EBS (Elastic Block Store)

# Usage
To run this script, simply use the following command in the terminal from the directory where the script is located:
´´´
./listresources.sh
´´´

This command will initiate the process of listing resources for the supported services across all AWS regions available in your account.

# Script Structure

## Fetching Regions:

The script begins by fetching a list of all available AWS regions using the command aws ec2 describe-regions.
The list of regions is stored in a variable for later iteration.

## Iterating Over Regions:

For each region, the script prints the region's name and then retrieves all the ARNs (Amazon Resource Names) of the resources in that region using aws resourcegroupstaggingapi get-resources.

## Processing Resources:

For each ARN obtained, the script determines the resource type by splitting the ARN into parts.
Depending on the resource type, the script executes the appropriate AWS CLI command to list the details of the corresponding resource.

## Unsupported Cases:

If the resource type is not supported by the script, an error message is printed, and the execution is terminated.

# Script Maintenance

- Updating Supported Services:

If you wish to add support for a new AWS service, you should add a new case in the case statement with the appropriate AWS CLI command to list that resource.


This script is useful for auditing AWS resources and ensuring that all services are being properly monitored.