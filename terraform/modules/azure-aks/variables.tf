variable "resource_group_name" {
  description = "Name of the resource group to create for the AKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "MC-AHAKS-Cluster"
}

variable "location" {
  description = "Azure region to deploy the AKS cluster"
  type        = string
  default     = "Central India"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = "1.32.0"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for the nodes in the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "subnet_id" {
  description = "Optional subnet ID for the AKS default node pool"
  type        = string
  default     = null
}
