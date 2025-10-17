terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key            = "aws-go-poc/terraform/state"
    bucket         = "my-terraform-state-bucket-ap-south-1"
    dynamodb_table = "terraform-state-locking-table"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
