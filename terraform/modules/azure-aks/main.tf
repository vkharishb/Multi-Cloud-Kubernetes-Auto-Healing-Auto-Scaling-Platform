terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.48.0, < 5.0"
    }
  }
}

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "~> 11.0"   # pin to a specific major version

  # Cluster identity
  resource_group_name = var.resource_group_name
  cluster_name         = var.cluster_name
  location             = var.location
  kubernetes_version   = var.kubernetes_version
  vnet_subnet_id      = var.subnet_id
  private_cluster_enabled = true
  network_plugin          = "azure"
  network_policy          = "azure"
  # Default node pool (flattened variables, not a block)
  agents_pool_name = "default"
  agents_count     = var.node_count
  agents_size      = var.vm_size
}