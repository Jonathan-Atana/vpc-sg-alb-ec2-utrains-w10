terraform {
  backend "s3" {
    bucket  = "replace this with your bucket name"
    key     = "dev/utrains-w10-alb-terraform/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}