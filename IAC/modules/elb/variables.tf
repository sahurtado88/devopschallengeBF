variable "environment" {
    description = "Environment"
    type= string
    default= "dev"
}

variable "public_subnets_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
}


variable "elb_sg_id" {
  description = "value"
  type = string
}

variable "ssl_certificate_arn"{}