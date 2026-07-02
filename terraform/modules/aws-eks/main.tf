terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

locals {
  cluster_name = var.cluster_name != "" ? var.cluster_name : "${var.cluster_name}-${var.env}-eks"
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "${local.cluster_name}-cluster-autoscaler"
  description = "Allow Kubernetes Cluster Autoscaler to discover and scale EKS managed node groups"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled"               = "true"
            "aws:ResourceTag/k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
          }
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Environment = var.env
    Terraform   = "true"
    ManagedBy   = "terraform"
    Owner       = "harish"
  })
}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.cluster_name
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

      iam_role_additional_policies = {
        cluster_autoscaler = aws_iam_policy.cluster_autoscaler.arn
      }

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
        Environment                                       = var.env
        NodeGroup                                         = "general"
        "k8s.io/cluster-autoscaler/enabled"               = "true"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
        "kubernetes.io/cluster/${local.cluster_name}"     = "owned"
      })
    }
  }

  tags = merge(var.tags, {
    Environment = var.env
    Terraform   = "true"
    ManagedBy   = "terraform"
    Owner       = "harish"
  })
}
