terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
# AWS provider
provider "aws" {
  region = var.aws_region
}


resource "aws_vpc" "weather_wiz_vpc" {
  cidr_block = var.vpc.cidr_block
  tags = {
    name = var.vpc.name
    env  = var.vpc.env
  }
}