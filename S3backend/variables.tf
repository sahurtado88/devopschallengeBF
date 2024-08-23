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