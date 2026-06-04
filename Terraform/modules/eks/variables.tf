variable "region" {
    description = "AWS region to deploy the EKS cluster"
    type        = string
    default     = "ap-south-2"
}

variable "cluster_name" {
    description = "Name of the EKS cluster"
    type        = string
    default     = "MC-AHEKS-Cluster"
}

variable "cluster_version" {
    description = "Kubernetes version for the EKS cluster"
    type        = string
    default     = "1.32"
}

variable "subnets" {
    description = "List of subnet IDs for the EKS cluster"
    type        = list(string)
}

variable "vpc_id" {
    description = "VPC ID for the EKS cluster"
    type        = string
}

variable "node_instance_type" {
    description = "EC2 instance type for the EKS worker nodes"
    type        = string
    default     = "t3.medium"
}

variable "node_capacity" {
    description = "Desired number of worker nodes in the EKS cluster"
    type        = number
    default     = 2
}

variable "max_node_capacity" {
    description = "Maximum number of worker nodes in the EKS cluster"
    type        = number
    default     = 3
}

variable "min_node_capacity" {
    description = "Minimum number of worker nodes in the EKS cluster"
    type        = number
    default     = 1
}

