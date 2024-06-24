variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc" {
  description = "The VPC configuration."
  type        = object({
    cidr_block = string
    name       = string
    env        = string
  })
  default = {
    cidr_block = ""
  
}