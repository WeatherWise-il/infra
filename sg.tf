resource "aws_security_group" "public_security_group" {
  tags = {
    Name = "weather_wiz_public_sg"
  }
  name   = "weather_wiz_public_sg"
  vpc_id = module.weather_wiz_app_vpc.vpc_id
}

resource "aws_security_group" "private_security_group" {
  tags = {
    Name = "weather_wiz_private_sg"
  }
  name   = "weather_wiz_private_sg"
  vpc_id = module.weather_wiz_app_vpc.vpc_id
  
}


resource "aws_vpc_security_group_ingress_rule" "allow_public_http" {
  tags = {
    Name = "Allow HTTP inbound traffic"
  }
  security_group_id = aws_security_group.public_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_mysql_access" {
  tags = {
    Name = "Allow MySQL inbound traffic"
  }
  security_group_id = aws_security_group.private_security_group.id
  cidr_ipv4         = var.weather_wiz_private_subnet.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_private_mysql_access" {
  tags = {
    Name = "Allow MySQL outbound traffic"
  }
  security_group_id = aws_security_group.private_security_group.id
  cidr_ipv4         = var.weather_wiz_private_subnet.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}
