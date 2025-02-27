resource "aws_vpc" "pse_mongo_vpc" {
  cidr_block           = "192.168.0.0/16"  # Updated CIDR block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "pse_mongo_vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.1.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.2.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2

  tags = {
    Name = "Public_Subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.3.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3

  tags = {
    Name = "Public_Subnet_3"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.4.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE1

  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.5.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE2

  tags = {
    Name = "Private_Subnet_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.pse_mongo_vpc.id
  cidr_block              = "192.168.6.0/24"  # Updated CIDR block
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE3

  tags = {
    Name = "Private_Subnet_3"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.pse_mongo_vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.pse_mongo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Public_RT_PSE_Tasky"
  }
}

resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet_2b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet_3c" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_RT.id
}
