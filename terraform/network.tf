#create VPC structure, along with subnets.

resource "aws_vpc" "main_vpc" {
	
	cidr_block = var.VPC_cidr_block
	enable_dns_hostnames = true 
	tags = {
		Name = "RL-Aline-VPC"
	}
}

#create subnets.

resource "aws_subnet" "public_subnet" {

	vpc_id = aws_vpc.main_vpc.id
	cidr_block = var.public_subnet_cidr_block
	tags = {
		Name = "Public_Subnet"
		CLUSTER_NAME = "RL-Cluster"
	}

}

resource "aws_subnet" "private_subnet" {
	
	vpc_id = aws_vpc.main_vpc.id
	cidr_block = var.private_subnet_cidr_block
	tags = {
		Name = "Private_Subnet"
		CLUSTER_NAME = "RL-Cluster"
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
	
	subnet_id = aws_subnet.private_subnet.id
    connectivity_type = "private"
	tags = {
		Name = "RL-nat-gw"
	}

    depends_on = [aws_internet_gateway.internet_gw]

}

#create route table.

resource "aws_route_table" "rt" {

	vpc_id = aws_vpc.main_vpc.id

	route {
		cidr_block = var.public_subnet_cidr_block
		gateway_id = aws_internet_gateway.internet_gw.id
	}

	route {
		cidr_block = var.private_subnet_cidr_block
		nat_gateway_id = aws_nat_gateway.nat_gw.id
	}

	tags = {
		Name = "RL-rt"
	}

}

#associate subnets and gateways with route table?

resource "aws_route_table_association" "pub_subnet_rta" {
    
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt.id

}

resource "aws_route_table_association" "priv_subnet_rta" {
    
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.rt.id

}

resource "aws_route_table_association" "internet_gateway_rta" {
    
    gateway_id = aws_internet_gateway.internet_gw.id
    route_table_id = aws_route_table.rt.id

}

resource "aws_route_table_association" "nat_gateway_rta" {
    
    gateway_id = aws_nat_gateway.nat_gw.id
    route_table_id = aws_route_table.rt.id

}
