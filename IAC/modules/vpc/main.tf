# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

# SUBNETS
resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnets_cidr,count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets_cidr)
  vpc_id     = aws_vpc.this.id
  cidr_block = element(var.private_subnets_cidr,count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.environment}-private-subnet-${count.index + 1}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# ROUTE TABLES
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}


#ELASTIC IP
resource "aws_eip" "eip" {
        count = length(var.public_subnets_cidr)
        tags = {
        Name = "${var.environment}-eip-${count.index + 1}"
    }
  
}

# NatGateway
resource "aws_nat_gateway" "nat-gw" {
    count = length(var.public_subnets_cidr)
    allocation_id = aws_eip.eip.*.id[count.index]
    subnet_id = element(aws_subnet.public[*].id, count.index)
    tags = {
      Name = "${var.environment}-nat-gw-${count.index + 1}"
    }
  depends_on = [ aws_eip.eip ]
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  count  = length(var.public_subnets_cidr)
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw[count.index].id
  }
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}