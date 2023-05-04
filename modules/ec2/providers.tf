terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = ">= 4.0"
    namedotcom = {
      source  = "lexfrei/namedotcom"
      version = "1.2.5"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "namedotcom" {
  username = var.namedotcom_username
  token    = var.namedotcom_token
}
