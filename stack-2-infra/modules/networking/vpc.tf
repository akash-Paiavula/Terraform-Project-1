locals{
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  az_names = data.aws_availability_zones.azs.names

}
resource "aws_vpc" "akash_vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "akash-${var.env_name}-vpc"
    }
}


resource "aws_subnet" "Public_subnets" {
  count = local.public_subnet_count
  vpc_id = aws_vpc.akash_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone =  local.az_names[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "akash-${var.env_name}--pub-${count.index + 1}"
  }
  
}

resource "aws_subnet" "Private_subnets" {
  count =  local.private_subnet_count
  vpc_id = aws_vpc.akash_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + local.public_subnet_count)
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "akash-${var.env_name}--pri-${count.index + 1}"
  }
  
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.akash_vpc.id

  tags = {
    Name = "akash_IGW"
  }
}


resource "aws_eip" "akash-elastic-ip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gatway" {
  allocation_id = aws_eip.akash-elastic-ip.id
  subnet_id = aws_subnet.Public_subnets[0].id
  depends_on = [ aws_internet_gateway.igw ]


  tags = {
     Name = "akash-${var.env_name}--nat-gateway"
  }
  
}

#######----Public----########

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.akash_vpc.id

  tags = {
    Name = "akash-public-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  
}

resource "aws_route_table_association" "public" {
  count = local.public_subnet_count
  subnet_id = aws_subnet.Public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

######------Private-------#######

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.akash_vpc.id
    tags = {
    Name = "akash-private-rt"
  }
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gatway.id
  
}

resource "aws_route_table_association" "Private" {
  count = local.private_subnet_count
  subnet_id = aws_subnet.Private_subnets[count.index].id
  route_table_id = aws_route_table.private-rt.id
  
}