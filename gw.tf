resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.setup_eks.id

  tags = {
    "Name" = "${var.name}-igw"
  }

  depends_on = [
    aws_vpc.setup_eks
  ]

}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.setup_eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-default-rt"
  }

}

resource "aws_route_table_association" "internet_access" {
  count = var.az_count

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.main.id
}

resource "aws_eip" "main" {
  vpc = "true"

  tags = {
    Name = "${var.name}-ngw-ip"
  }

}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.private_subnet[0].id

  tags = {
    Name = "${var.name}-ngw"
  }
}

resource "aws_route" "main" {
  route_table_id         = aws_vpc.setup_eks.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"

}

