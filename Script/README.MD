# Description
This Bash script automates the process of listing all resources in an AWS account across multiple regions. It currently supports fetching resources for the following AWS services:

- EC2 (Elastic Compute Cloud)
- RDS (Relational Database Service)
- S3 (Simple Storage Service)
- CloudFront
- VPC (Virtual Private Cloud)
- IAM (Identity and Access Management)
- Route53
- CloudWatch
- CloudFormation
- Lambda
- SNS (Simple Notification Service)
- SQS (Simple Queue Service)
- DynamoDB
- EBS (Elastic Block Store)

# Prerequesites
To successfully execute the listresources.sh script, the following prerequisites must be met:

## AWS CLI Installed:

The AWS Command Line Interface (CLI) must be installed on the machine where the script is run. You can install it using the following guide https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## AWS CLI Configured:

The AWS CLI must be properly configured with your AWS credentials and default region. This can be done using:
```
aws configure
```
You will need to provide your AWS Access Key ID, Secret Access Key, default region name, and default output format.

## IAM Permissions:

The AWS user whose credentials are used to run the script must have sufficient permissions to list resources across all the services specified in the script. This includes permissions like:

- ec2:DescribeInstances
- rds:DescribeDBInstances
- s3:ListAllMyBuckets
- cloudfront:ListDistributions
- iam:ListUsers
- route53:ListHostedZones
- cloudwatch:DescribeAlarms
- cloudformation:DescribeStacks
- lambda:ListFunctions
- sns:ListTopics
- sqs:ListQueues
- dynamodb:ListTables
- ec2:DescribeVolumes
- resourcegroupstaggingapi:GetResources


The script is written in Bash, so it needs to be run in a Bash-compatible shell. Most Linux and macOS systems come with Bash pre-installed. On Windows, you can use Git Bash, WSL (Windows Subsystem for Linux), or a similar environment.

## Execution Permissions:

The script is written in Bash, so it needs to be run in a Bash-compatible shell. Most Linux and macOS systems come with Bash pre-installed. On Windows, you can use Git Bash, WSL (Windows Subsystem for Linux), or a similar environment.

Ensure the script has execute permissions. If not, you can add execute permissions with the following command:
```
chmod +x listresources.sh
```



# Usage
To run this script, simply use the following command in the terminal from the directory where the script is located:

```
./listresources.sh
```

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