# This Terraform configuration file sets up an Amazon EKS (Elastic Kubernetes Service) cluster using the official EKS module from the Terraform Registry.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.42.0"
    }
  }
}

# Provider configuration for AWS
provider "aws" {
  region = var.region
}

# Using the official EKS module from the Terraform Registry
module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Cluster naming and versioning
  name            = var.cluster_name
  kubernetes_version = var.cluster_version

  # Network configuration
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  # Endpoint access configuration
  endpoint_private_access = var.cluster_endpoint_private_access
  endpoint_public_access  = var.cluster_endpoint_public_access
  endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # IP configuration
  ip_family = "ipv4"

  # Managed node groups
  eks_managed_node_groups = {
    general = {
      name            = "${var.cluster_name}-node-group"
      use_name_prefix = true
      capacity_type   = "ON_DEMAND"

      # Scaling configuration
      min_size     = var.min_node_capacity
      max_size     = var.max_node_capacity
      desired_size = var.node_capacity

      # Instance configuration
      instance_types = [var.node_instance_type]

      # Volume configuration
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 100
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            delete_on_termination = true
            encrypted             = true
          }
        }
      }

      labels = {
        Environment = "production"
        NodeGroup   = "general"
      }

      tags = {
        Environment = "production"
        NodeGroup   = "general"
      }
    }
  }

  # Cluster tags
  tags = {
    Environment = "production"
    Terraform   = "true"
    ManagedBy   = "terraform"
  }
}
