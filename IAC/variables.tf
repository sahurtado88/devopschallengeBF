variable "region" {
  description = "Aws region to deploy infraestructure"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain name"
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

variable "elb_dns_name" {
  description = "value"
  type        = string

}

variable "subdomain" {
  description = "subdomain name"
  type        = string
}

variable "elb_sg_id" {
  description = "value"
  type        = string
}

variable "ssl_certificate_arn" {}