resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name          = var.name
    resource_type = "AWS VPC"
  }
}

resource "aws_subnet" "public" {
  availability_zone = local.subnets_availability_zones[0]
  cidr_block        = local.subnet_cidrs[0]
  vpc_id            = aws_vpc.main.id
  tags = {
    Name          = "${var.name} public sunet"
    resource_type = "Subnet"
  }
}

resource "aws_subnet" "private" {
  availability_zone = local.subnets_availability_zones[1]
  cidr_block        = local.subnet_cidrs[1]
  vpc_id            = aws_vpc.main.id
  tags = {
    Name          = "${var.name} private sunet"
    resource_type = "Subnet"
  }

}

resource "aws_route_table" "public_" {
  vpc_id = aws_vpc.main.id
  # Note: By default, the local route is created and cannot be specified.

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name          = "${var.name} route table"
    resource_type = "Route Table"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "public" {
  name        = "${var.name}-public-sg"
  description = "${var.name} public subnet SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow TLS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-public-sg"
    resource_type = "Security Group"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.name}-private-sg"
  description = "${var.name} private subnet SG"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-private-sg"
    resource_type = "Security Group"
  }
}
