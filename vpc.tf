locals {
  tags = {
    Owner       = "TFE"
    Environment = "dev"
    Name        = "setup-eks"
  }
}



module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  intra_subnets   = ["10.0.7.0/28", "10.0.7.16/28", "10.0.7.32/28"]

  enable_dns_support = "true"
  enable_nat_gateway = "true"
  single_nat_gateway = "true"

  enable_flow_log                      = "false"
  create_flow_log_cloudwatch_iam_role  = "false"
  create_flow_log_cloudwatch_log_group = "false"

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags
}


/*
resource "aws_vpc" "setup_eks" {
  cidr_block           = "10.17.0.0/24"
  enable_dns_hostnames = "false"
  enable_dns_support   = "false"

  tags = local.tags
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.0/27"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = "false"

  tags = local.tags
}
resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.32/27"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = "false"

  tags = local.tags
}
resource "aws_subnet" "private_subnet3" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.64/27"
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = "false"

  tags = local.tags
}
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.128/27"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = "true"

  tags = local.tags
}
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.160/27"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = "true"

  tags = local.tags
}
resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = "10.17.0.192/27"
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = "true"

  tags = local.tags
}
*/
