/*
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name                    = var.name
  cluster_endpoint_private_access = "true"
  cluster_endpoint_public_access  = "true"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  tags = local.tags
}*/