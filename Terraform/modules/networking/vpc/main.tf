terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#PRovider configuration for AWS, specifying the region to deploy the EKS cluster
provider "aws" {
    region = var.region
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = var.vpc_name
    cidr = var.cidr_block
    azs             = var.availability_zones
    public_subnets  = var.public_subnet_cidrs
    private_subnets = var.private_subnet_cidrs
    enable_dns_hostnames = true
    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}