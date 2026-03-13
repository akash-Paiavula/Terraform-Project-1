provider "aws" {
  region = "ap-south-1"

  assume_role {
    role_arn = "arn:aws:iam::372110294419:role/terraform-admin"
    session_name = "terraform-access"
  }
}

terraform {
  required_version = "1.13.4"
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "6.34.0"
    }
  }
  backend "s3" {
    bucket = "akash-terraform-app-infra-state-bucket-1"
    key = "envs/dev/app/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile = true
  }
}