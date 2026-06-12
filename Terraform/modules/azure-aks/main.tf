terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}
#Provider configuration for Azure, specifying the features block which is required for the azurerm provider
provider "azurerm" {
  features {}
}

module "aks" {
  source = "Azure/aks/azurerm"

  #AKS cluster configuration
  resource_group_name = var.resource_group_name   #Name of the resource group to create for the AKS cluster
  cluster_name        = var.cluster_name          #Name of the AKS cluster
  location            = var.location              #Azure region to deploy the AKS cluster
  kubernetes_version  = var.kubernetes_version    #Kubernetes version for the AKS cluster

  #Node pool configuration for the AKS cluster
  default_node_pool = {
    name       = "default"                      #Name of the default node pool
    node_count = var.node_count                 #Number of nodes in the default node pool
    vm_size    = var.vm_size                    #VM size for the nodes in the default node pool
  }

}