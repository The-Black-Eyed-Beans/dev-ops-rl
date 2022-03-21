
terraform {
  required_version = ">= 1.0.0"
}


#create VPC structure, along with subnets.

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.VPC_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "RL-Aline-VPC"
  }
}

#create subnets.

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name         = "RL-Public_Subnet-${count.index}"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name         = "RL-Private_Subnet-${count.index}"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

#create internet and NAT gateway.

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "RL-internet-gw"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id         = aws_subnet.public_subnets[0].id #will always put the NAT gateway in the first public subnet created. 
  connectivity_type = "private"
  tags = {
    Name = "RL-nat-gw"
  }

  depends_on = [aws_internet_gateway.internet_gw]
}

#create route tables.

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "RL-pub-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "RL-private-rt"
  }
}

#associate subnets and gateways with route table.

resource "aws_route_table_association" "pub_subnet_rta" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "priv_subnet_rta" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
