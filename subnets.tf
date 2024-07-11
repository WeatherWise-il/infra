resource "aws_subnet" "weather_wiz_public_subnet" {
  count                   = local.azs_count
  cidr_block              = cidrsubnet(aws_vpc.weather_wiz_vpc.cidr_block, 8, 10 + count.index)
  availability_zone       = local.azs_names[count.index]
  vpc_id                  = aws_vpc.weather_wiz_vpc.id
  map_public_ip_on_launch = true
  tags = merge(var.common_tags)
}


resource "aws_route_table" "weather_wiz_public_route_table" {
  vpc_id = aws_vpc.weather_wiz_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.weather_wiz_igw.id
  }
 tags = {
    Name = "weather_wiz_public_route_table"
  }
}

resource "aws_route_table_association" "public" {
  count          = local.azs_count
  subnet_id      = aws_subnet.weather_wiz_public_subnet[count.index].id
  route_table_id = aws_route_table.weather_wiz_public_route_table.id
}

resource "aws_eip" "nat_gateway" {
  tags = merge(var.common_tags)
}


# resource "aws_nat_gateway" "nat_gateway" {
#   subnet_id     = aws_subnet.weather_wiz_public_subnet.id
#   allocation_id = aws_eip.nat_gateway.id
#   tags = merge(var.common_tags)
# }

# resource "aws_subnet" "weather_wiz_private_subnet" {
#   availability_zone = var.aws_region
#   cidr_block        = var.weather_wiz_private_subnet.cidr_block
#   vpc_id            = aws_vpc.weather_wiz_vpc.id

#     tags = merge(var.common_tags)
# }


# resource "aws_route_table" "weather_wiz_private_route_table" {
#   vpc_id = aws_vpc.weather_wiz_vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gateway.id
#   }
#    tags = {
#     Name = "weather_wiz_private_route_table"
#   }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.weather_wiz_private_subnet.id
#   route_table_id = aws_route_table.weather_wiz_private_route_table.id
# }