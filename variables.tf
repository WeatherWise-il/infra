variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1a"
}

variable "weather_wiz_vpc" {
  description = "The VPC configuration."
  type = object({
    cidr_block = string
    name       = string
  })
  default = {
    cidr_block = "192.168.0.0/16"
    name       = "weather_wiz_vpc"
  }
}

variable "weather_wiz_public_subnet" {
  description = "The public subnet configuration."
  type = object({
    cidr_block = string
    name       = string
    vpc_getway = bool
  })
  default = {
    cidr_block = "192.168.1.0/24"
    name       = "weather_wiz_public_subnet"
    vpc_getway = true
  }
}


variable "weather_wiz_private_subnet" {
  description = "The private subnet configuration."
  type = object({
    cidr_block = string
    name       = string
    vpc_getway = bool
  })
  default = {
    cidr_block = "192.168.2.0/24"
    name       = "weather_wiz_private_subnet"
    vpc_getway = true
  }
}


variable "common_tags" {
  type = map(string)
  default = {
    Terraform = "true"
    env       = "prod"
  }
}


# variable "weather_wiz_vpc_ecr_repositories" {
#   description = "The VPC configuration."
#   type = object({
#     repository_name = ""
#   })
#   default = {
#     repository_name = "weather_wiz_app_repository"
#     repository_type = "private"
#   }
# }

variable "aws_user" {
  description = "The AWS user configuration."
  type = object({
    name = string
  })
  default = {
    name = "weather_wiz_app_user"
  }
}

variable "amazon_linux_ec2" {
  description = "linux instance configuration"
  type = object({
    name          = string
    instance_type = string
    count         = number
    env           = string
  })
  default = {
    name          = "cyberbit-linux-ec2"
    instance_type = "t2.micro"
    count         = 2
    env           = "dev"
  }
}

variable "ssh_key_path" {
  description = "The path to the SSH key"
  type        = string
  default     = "~/.ssh/weather_wiz.pem"

}