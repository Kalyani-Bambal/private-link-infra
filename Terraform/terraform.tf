terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.22.1"
    }
  }

  backend "s3" {
    bucket  = "kalyani-private-link-infra"
    key     = "terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}

provider "aws" {
  region     = "ap-northeast-2"
}