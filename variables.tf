variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1a"
}

variable "weather_wiz_vpc" {
  description = "The VPC configuration."
  type        = object({
    cidr_block = string
    name       = string
  })
  default = {
    cidr_block = "192.168.0.0/16"
    name = "weather_wiz_vpc"
}
}

variable "weather_wiz_public_subnet" {
  description = "The public subnet configuration."
  type        = object({
    cidr_block = string
    name       = string
    vpc_getway = bool
  })
  default = {
    cidr_block = "192.168.1.0/24"
    name = "weather_wiz_public_subnet"
    vpc_getway = true
}
}

variable "common_tags" {
  type = map(string)
  default = {
    Terraform = "true"
    env  = "prod"
  }
}