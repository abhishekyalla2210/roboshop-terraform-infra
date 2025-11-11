terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }

   backend "s3" {
    bucket = "remote-state-devsecops"
    key    = "remote-state-bastion"
    region = "us-east-1"
    use_lockfile = false
    encrypt = true
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}