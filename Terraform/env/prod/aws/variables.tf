# ==============================================================================
# AWS REGION & ENVIRONMENT CONFIGURATION
# ==============================================================================
variable "region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# ==============================================================================
# VPC & NETWORK CONFIGURATION
# ==============================================================================
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "mck-eks-vpc"
}

variable "cidr_block" {
  description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

# ==============================================================================
# EKS CLUSTER CONFIGURATION
# ==============================================================================
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "mck-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster (e.g., 1.30)"
  type        = string
  default     = "1.34"
}

# ==============================================================================
# EKS NODE GROUP CONFIGURATION
# ==============================================================================
variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 3
}

variable "min_node_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_node_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}
