variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
}

variable "public_subnets_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
}

variable "private_subnets_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
}


variable "environment" {
    description = "Environment"
    type= string
    default= "dev"
}
