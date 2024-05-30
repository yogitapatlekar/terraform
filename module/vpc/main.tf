resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.project}-vpc"
    Env  = var.env
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.project}-private-subnet"
    Env  = var.env
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-public-subnet"
    Env  = var.env
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_route" "igw_route" {
  route_table_id         = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}
