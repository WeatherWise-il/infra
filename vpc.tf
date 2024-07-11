
data "aws_availability_zones" "available" { state = "available" }

locals {
  azs_count = 2
  azs_names = data.aws_availability_zones.available.names
}

resource "aws_vpc" "weather_wiz_vpc" {
  cidr_block           = var.weather_wiz_vpc.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.common_tags)
}

resource "aws_internet_gateway" "weather_wiz_igw" {
  vpc_id = aws_vpc.weather_wiz_vpc.id
  tags = merge(var.common_tags)
}