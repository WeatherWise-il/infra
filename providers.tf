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
   backend "s3" {
    bucket         = "weather-wiz-terraform-state"
    region         = "us-east-1"
    key            = "weather_wiz/terraform.tfstate"
    encrypt = true
  }
}
# AWS provider
provider "aws" {
  region = "us-east-1"
}