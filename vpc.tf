resource "aws_vpc" "setup_eks" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name                                        = "${var.name}-vpc",
    "kubernetes.io/cluster/${var.name}-cluster" = "shared"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.az_count

  vpc_id                  = aws_vpc.setup_eks.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index + var.az_count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false"

  tags = {
    Name                                        = "${var.name}-private-sg"
    "kubernetes.io/cluster/${var.name}-cluster" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

resource "aws_subnet" "public_subnet" {
  count = var.az_count

  vpc_id            = aws_vpc.setup_eks.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = "true"

  tags = {
    Name                                        = "${var.name}-public-sg"
    "kubernetes.io/cluster/${var.name}-cluster" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

/*
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
    "kubernetes.io/role/internal-elb"   = 1
  }

  tags = local.tags
}*/