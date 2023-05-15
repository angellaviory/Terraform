#AWS Hashicorp Provider Section
provider "aws" {
  region     = "ap-southeast-1"
  access_key = "enter_your_access_key"
  secret_key = "enter_your_secret_key"
}

#Instance Section
resource "aws_instance" "instance_name" {
  ami = "ami_id"
  instance_type = "instance_type"
  count = "number_of_instance"
  tags = {
    Name = "instance_name"
  }
}

#VPC Section
resource "aws_vpc" "vpc_name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_name"
  }
}

#Subnet Section
resource "aws_subnet" "subnet_name" {
  vpc_id = aws_vpc."vpc_name".id
  cidr_block = "10.0.1.0/24"
}

#IGW Section
resource "aws_internet_gateway" "igw_name" {
  vpc_id = aws_vpc."vpc_name".id
}

#Route Table Section 
resource "aws_route_table" "router_table_name" {
  vpc_id = aws_vpc."vpc_name".id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_name.id
  }
}

#Route Table Associate Section
resource "aws_route_table_association"  "rta_name" {
  subnet_id = aws_subnet."subnet_name".id
  route_table_id = aws_route_table."rt_name".id
}

#Security Group 
resource "aws_security_group" "sg_name" {
  name        = "sg_name"
  description = "Allow TLS inbound traffic" #optional
  vpc_id      = aws_vpc."vpc_name".id

#inboud
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

#outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "name_tags"
  }
}

