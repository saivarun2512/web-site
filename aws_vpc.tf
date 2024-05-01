resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs
  availability_zone = var.az

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs
  availability_zone = var.az

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "my_routetable"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.routetable.id
}

