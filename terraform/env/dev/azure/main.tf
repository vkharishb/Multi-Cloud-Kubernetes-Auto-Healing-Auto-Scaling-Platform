module "vnet" {
  source              = "../../../modules/azure-Vnet"
  vnet_name           = "${var.name}-${var.env}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  subnets             = var.subnets
}

module "aks" {
  source              = "../../../modules/azure-aks"
  
  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = "${var.name}-${var.env}-aks"
  node_count          = var.node_count
  subnet_id           = module.vnet.aks_subnet_id
}