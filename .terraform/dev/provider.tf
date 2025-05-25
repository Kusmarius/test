terraform {
  required_version = "1.11.4"

  backend "s3" {
    bucket = "zfi-terraform-dev"
    key = "terraform-dev.tfstate"
    encrypt = true
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "${var.region}"
}
