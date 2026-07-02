module "vpc" {
  source               = "../../../modules/aws-vpc"
  vpc_name             = "${var.name}-${var.env}-vpc"
  cidr_block           = var.cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source          = "../../../modules/aws-eks"
  cluster_name = "${var.name}-${var.env}-eks"
  env             = var.env
  cluster_version = var.eks_cluster_version
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
}
