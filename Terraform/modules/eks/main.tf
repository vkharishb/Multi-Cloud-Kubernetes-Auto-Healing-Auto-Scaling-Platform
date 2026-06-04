# This Terraform configuration file sets up an Amazon EKS (Elastic Kubernetes Service) cluster using the official EKS module from the Terraform Registry. It defines the necessary provider configuration for AWS and specifies the parameters for creating the EKS cluster, including network settings and managed node group configurations.
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

#Using the official EKS module from the Terraform Registry to create an EKS cluster with managed node groups
module "eks" {
    # Using the official EKS module from the Terraform Registry
    source          = "terraform-aws-modules/eks/aws"

    #EKS cluster configuration
    cluster_name    = var.cluster_name           #Name of the EKS cluster
    cluster_version = var.cluster_version        #Kubernetes version for the EKS cluster

   #Network configuration for the EKS cluster
    subnet_ids     = var.subnets
    vpc_id         = var.vpc_id

    # Managed node group configuration for the EKS cluster
    eks_managed_node_group_defaults = {
        instance_types = [var.node_instance_type]    # EC2 instance type for the worker nodes
    }

    eks_managed_node_groups = {
        eks_nodes = {
            scaling_config = {
                desired_size = var.node_capacity        # desired capacity of worker nodes
                max_size     = var.max_node_capacity    # maximum capacity of worker nodes
                min_size     = var.min_node_capacity    # minimum capacity of worker nodes
            }
            instance_types = [var.node_instance_type]    # EC2 instance type for the worker nodes
        }
    }
}
