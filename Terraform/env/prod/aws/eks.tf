# ==============================================================================
# 0. PROVIDER CONFIGURATION
# ==============================================================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.42.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# ==============================================================================
# 1. NETWORK (VPC) INSTANTIATION
# ==============================================================================
module "vpc" {
  # Note: If this is a local folder wrapper, remove the 'version' property.
  # If you want versioning, point directly to the registry: "terraform-aws-modules/vpc/aws"
  source = "../modules/network/vpc"

  # Inputs must come from variables, NOT from the module's own outputs
  vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
}

# ==============================================================================
# 2. EKS CLUSTER INSTANTIATION
# ==============================================================================
module "eks" {
  source = "../modules/eks"
  #version = "~> 5.0" 

  # Core Cluster Config (Fed from variables, avoiding self-referencing loops)
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version # e.g., "1.34"

  # Network Linkage (Correctly mapped from the VPC module outputs)
  # Using outputs from the VPC module defined above
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets 

  # Compute/Worker Node Sizing (Fed from variables)
  node_instance_type = var.node_instance_type
  node_capacity      = var.node_capacity
  max_node_capacity  = var.max_node_capacity
  min_node_capacity  = var.min_node_capacity

  # Endpoint Access & Security Settings
  cluster_endpoint_public_access  = true 
  cluster_endpoint_private_access = true
  
  # For absolute stability, ensure your local module enforces KMS encryption 
  # for Kubernetes secrets inside its underlying resource declarations.
}