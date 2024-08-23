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

    for arn in $resource_arn
    do
        echo "resourse ARN: $arn
        resource_type=$(echo $arn | cut -d':' -f6)
        resource_id=$(echo $arn | cut -d':' -f2) )

        case $resource_type in
            ec2)
                echo "Listing EC2 Instances in $region" 
                aws ec2 describe-instances --region $region --output json
                ;;
            rds)
                echo "Listing RDS Instances in $region"
                aws rds describe-db-instances --region $region --output json
                ;;
            s3)
                echo "Listing S3 Buckets in $region"
                aws s3api list-buckets --region $region --output json
                ;;
            cloudfront)
                echo "Listing CloudFront Distributions in $region"
                aws cloudfront list-distributions --region $region --output json
                ;;
            vpc)
                echo "Listing VPCs in $region"
                aws ec2 describe-vpcs --region $region --output json
                ;;
            iam)
                echo "Listing IAM Users in $region"
                aws iam list-users --region $region --output json
                ;;
            route53)
                echo "Listing Route53 Hosted Zones in $region"
                aws route53 list-hosted-zones --region $region --output json
                ;;
            cloudwatch)
                echo "Listing CloudWatch Alarms in $region"
                aws cloudwatch describe-alarms --region $region --output json
                ;;
            cloudformation)
                echo "Listing CloudFormation Stacks in $region"
                aws cloudformation describe-stacks --region $region --output json
                ;;
            lambda)
                echo "Listing Lambda Functions in $region"
                aws lambda list-functions --region $region --output json
                ;;
            sns)
                echo "Listing SNS Topics in $region"
                aws sns list-topics --region $region --output json
                ;;
            sqs)
                echo "Listing SQS Queues in $region"
                aws sqs list-queues --region $region --output json
                ;;
            dynamodb)
                echo "Listing DynamoDB Tables in $region"
                aws dynamodb list-tables --region $region --output json
                ;;
            ebs)
                echo "Listing EBS Volumes in $region"
                aws ec2 describe-volumes --region $region --output json
                ;;
            *)
                echo "resource no detail: "$resource_type"  
                exit 1
                ;;
        esac
    done 
done