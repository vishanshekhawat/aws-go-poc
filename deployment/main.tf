terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "aws-go-poc-simple-ecs-terraform-state"
    key            = "terraform/state"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "aws-go-poc-simple-ecs-terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}
