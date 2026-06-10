provider "azurerm" {
  features {}
}

module "Vnet" {
  source = "Azure/vnet/azurerm"
  version = "3.0.0"
  vnet_name           = var.vnet_name
  resource_group_name = var.resource_group_name
  vnet_location       = var.location
  address_space       = var.address_space

}