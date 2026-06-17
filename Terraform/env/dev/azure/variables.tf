variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNET"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
  default = 2
}

variable "node_size" {
  description = "Size of the nodes in the AKS cluster"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "env" {
  description = "Environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "name" {
  description = "Project name"
  type        = string
  default     = "mcp"
}