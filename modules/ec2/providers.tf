terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = ">= 4.0"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "namedotcom" {
  username = var.namedotcom_username
  token    = var.namedotcom_token
}
