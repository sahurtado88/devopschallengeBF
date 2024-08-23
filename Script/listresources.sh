#!/bin/bash

###############################################################################
# Script to automate the process of listing all the resources in an AWS account

# Below are the services that are supported by this script:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS

# Usage: ./listresources.sh
###############################################################################

for region in `aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 --output text`
do
    echo "region = ${region}"
    resource_arn=$(aws resourcegroupstaggingapi get-resources --region ${region} --query 'ResourceTagMappingList[].ResourceARN' --output text);

    for arn in $resource_arns
    do
        echo "resourse ARN: $arn
        resource_type=$(echo $arn | cut -d':' -f6)
        resource_id=$(echo $arn | cut -d':' -f2) )

        case $resource_type in
            ec2)
                echo "Listing EC2 Instances in $aws_region" 
                aws ec2 describe-instances --region $aws_region --output json
                ;;
            rds)
                echo "Listing RDS Instances in $aws_region"
                aws rds describe-db-instances --region $aws_region --output json
                ;;
            s3)
                echo "Listing S3 Buckets in $aws_region"
                aws s3api list-buckets --region $aws_region --output json
                ;;
            cloudfront)
                echo "Listing CloudFront Distributions in $aws_region"
                aws cloudfront list-distributions --region $aws_region --output json
                ;;
            vpc)
                echo "Listing VPCs in $aws_region"
                aws ec2 describe-vpcs --region $aws_region --output json
                ;;
            iam)
                echo "Listing IAM Users in $aws_region"
                aws iam list-users --region $aws_region --output json
                ;;
            route53)
                echo "Listing Route53 Hosted Zones in $aws_region"
                aws route53 list-hosted-zones --region $aws_region --output json
                ;;
            cloudwatch)
                echo "Listing CloudWatch Alarms in $aws_region"
                aws cloudwatch describe-alarms --region $aws_region --output json
                ;;
            cloudformation)
                echo "Listing CloudFormation Stacks in $aws_region"
                aws cloudformation describe-stacks --region $aws_region --output json
                ;;
            lambda)
                echo "Listing Lambda Functions in $aws_region"
                aws lambda list-functions --region $aws_region --output json
                ;;
            sns)
                echo "Listing SNS Topics in $aws_region"
                aws sns list-topics --region $aws_region --output json
                ;;
            sqs)
                echo "Listing SQS Queues in $aws_region"
                aws sqs list-queues --region $aws_region --output json
                ;;
            dynamodb)
                echo "Listing DynamoDB Tables in $aws_region"
                aws dynamodb list-tables --region $aws_region --output json
                ;;
            ebs)
                echo "Listing EBS Volumes in $aws_region"
                aws ec2 describe-volumes --region $aws_region --output json
                ;;
            *)
                echo "resource no detail: "$resource_type"  
                exit 1
                ;;
        esac
    done 
done