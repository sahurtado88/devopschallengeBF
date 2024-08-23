#ELASTIC IP
resource "aws_eip" "eip" {
        count = length(var.public_subnets_cidr)
        tags = {
        Name = "${var.environment}-eip-${count}"
    }
  
}

# NAT GATEWAY
resource "aws_nat_gateway" "nat-gw" {
    count = length(var.public_subnets_cidr)
    allocation_id = aws_eip.eip.*.id[count.index]
    subnet_id = var.subnet_ids[count.index]
    tags = {
      Name = "${var.environment}-nat-gw-${count.index + 1}"
    }
  depends_on = [ aws_eip.eip ]
}

