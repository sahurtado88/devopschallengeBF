terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }

  /*   backend "s3" {
    bucket = "terraform-remote-backend-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table= "terraform_state_locks"
  } */
}

provider "aws" {
  region = var.region
}