terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-ja"
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