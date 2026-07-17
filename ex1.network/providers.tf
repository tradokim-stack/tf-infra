terraform {
#   required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    #   version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
    #   version = "~> 3.7"
    }
  }
}


provider "aws" {
#   profile = "dev"
  # region  = "us-east-1"
  region = "ap-southeast-1"
}

provider "random" {}
