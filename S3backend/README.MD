For use thi terraform the first thing you need is use the Terraform module thatprovision an S3 bucket to store the terraform.tfstate fiel and a DynamoDB table to lock the state file to prevent concurrent modifications and state corruption

 To allow customization and felxibility in this terraform module you need to define the  follow variables

 iam_user_name is used to set the name of the IAM user
 bucket_name define the name of the S3 bucket for storage the tf state
 table_name specifies the name of the dynamoDB table for state locking
 region to define in which region in AWS you work

 After you created the backend you need to save the values of the buket, key, region and dynamotbale to configure de S3 remote backend

 