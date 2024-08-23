variable "region" {
  description = "Aws region to deploy infraestructure"
  type        = string
}

variable "iam_user" {
  description = "IAM user name"
  type        = string
  default     = "terraform"
}

variable "bucket_name" {
  description = "bucket name to save terraform state"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "table_name" {
  description = "table name on dynamodb"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}

variable "public_subnets_cidr" {
  description = "Subnet CIDRS"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Subnet CIDRS"
  type        = list(string)
}
