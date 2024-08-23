variable "vpc_id" {
  description = "VPC ID for Security Group"
  type = string
}

variable "environment" {
    description = "Environment"
    type= string
    default= "dev"
}