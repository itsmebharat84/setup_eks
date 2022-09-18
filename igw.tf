resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.setup_eks.id

  tags = {
    "Name" = "${var.name}-igw"
  }

  depends_on = [
    aws_vpc.setup_eks
  ]

}