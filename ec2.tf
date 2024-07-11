# # Get the latest Amazon Linux 2 AMI ID for region
# data "aws_ami" "linux_ami" {
#   owners      = ["amazon"]
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.4.20240528.0-kernel-6.1-x86_64"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name   = "state"
#     values = ["available"]
#   }
# }

# resource "aws_instance" "linux" {
#   ami                         = data.aws_ami.linux_ami.id
#   instance_type               = var.amazon_linux_ec2.instance_type
#   subnet_id                   = aws_subnet.weather_wiz_public_subnet.id
#   vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  
#   count                       = var.amazon_linux_ec2.count
#   # key_name                    = aws_key_pair.cyberbit_key_pair.key_name
#   associate_public_ip_address = true
#   tags = merge(var.common_tags)
#  }