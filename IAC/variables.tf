variable "region" {
  description = "Aws region to deploy infraestructure"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "bucket" {
  description = "bucket name configured per environment"
  type        = string
}

variable "key" {
  description = "key name configured per environment"
  type        = string
}
variable "dynamodb_table" {
  description = "dynamo table configured per environment"
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
