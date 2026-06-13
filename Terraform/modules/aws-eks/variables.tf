variable "cluster_name" {
  description = "Base name of the EKS cluster"
  type        = string
  default     = "mcp"
}

variable "env" {
  description = "Environment name such as dev, stage, or prod"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "env must be one of: dev, stage, prod."
  }
}

variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "subnets" {
  description = "Private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "cluster_endpoint_private_access" {
  description = "Enable private endpoint access for EKS"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Enable public endpoint access for EKS"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDR blocks allowed to access the EKS public endpoint"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for cidr in var.cluster_endpoint_public_access_cidrs :
      can(cidrhost(cidr, 0))
    ])
    error_message = "Each value in cluster_endpoint_public_access_cidrs must be a valid CIDR block."
  }
}

variable "eks_admin_role_arn" {
  description = "IAM role ARN to grant EKS cluster admin access"
  type        = string
  default     = ""
}

variable "min_node_capacity" {
  description = "Minimum EKS node count"
  type        = number
  default     = 1

  validation {
    condition     = var.min_node_capacity >= 1
    error_message = "min_node_capacity must be greater than or equal to 1."
  }
}

variable "max_node_capacity" {
  description = "Maximum EKS node count"
  type        = number
  default     = 3

  validation {
    condition     = var.max_node_capacity >= 1
    error_message = "max_node_capacity must be greater than or equal to 1."
  }
}

variable "node_capacity" {
  description = "Desired EKS node count"
  type        = number
  default     = 2

  validation {
    condition     = var.node_capacity >= 1
    error_message = "node_capacity must be greater than or equal to 1."
  }
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_volume_size" {
  description = "EBS volume size for EKS nodes"
  type        = number
  default     = 50

  validation {
    condition     = var.node_volume_size >= 20
    error_message = "node_volume_size must be at least 20 GB."
  }
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}