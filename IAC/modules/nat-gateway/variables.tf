variable "public_subnets_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
}

variable "private_subnets_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
}

variable "vpc_id"{}
variable "internet_gateway"{}
variable "environment"{}

variable "subnet_ids" {
  description = "A list of subnet IDs in different Availability Zones"
  type        = list(string)
}