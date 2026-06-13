terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.cluster_name}-${var.env}-eks"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  enable_cluster_creator_admin_permissions = true

  access_entries = var.eks_admin_role_arn != "" ? {
    admin = {
      principal_arn = var.eks_admin_role_arn
      type          = "STANDARD"

      policy_associations = {
        cluster_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  } : {}

  eks_managed_node_groups = {
    general = {
      name            = "${var.cluster_name}-${var.env}-general"
      use_name_prefix = false
      capacity_type   = "ON_DEMAND"

      min_size     = var.min_node_capacity
      max_size     = var.max_node_capacity
      desired_size = var.node_capacity

      instance_types = [var.node_instance_type]

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = var.node_volume_size
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            delete_on_termination = true
            encrypted             = true
          }
        }
      }

      labels = {
        Environment = var.env
        NodeGroup   = "general"
      }

      tags = merge(var.tags, {
        Environment = var.env
        NodeGroup   = "general"
      })
    }
  }

  tags = merge(var.tags, {
    Environment = var.env
    Terraform   = "true"
    ManagedBy   = "terraform"
    Owner   = "harish"
  })
}