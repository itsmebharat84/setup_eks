locals {
  tags = {
    Owner       = "TFE"
    Environment = "dev"
    Name        = "setup-eks"
  }
}

/*
resource "aws_vpc" "setup-eks-vpc" {
  cidr_block = "10.17.0.0/24"

  tags = local.tags
}
*/

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name       = var.name
  cidr_block = "10.17.0.0/24"

  availability_zones         = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnet_cidr_blocks = ["10.17.0.0/27", "10.17.0.32/27", "10.17.0.64/27"]
  public_subnet_cidr_blocks  = ["10.17.0.128/27", "10.17.0.160/27", "10.17.0.192/27"]
}
