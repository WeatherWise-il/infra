module "weather_wiz_app_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.weather_wiz_vpc.name
  cidr = var.weather_wiz_vpc.cidr_block
  azs                     = ["us-east-1a"]
  public_subnets          = [var.weather_wiz_public_subnet.cidr_block]
  enable_vpn_gateway = true
  map_public_ip_on_launch = true
  tags = var.common_tags
}