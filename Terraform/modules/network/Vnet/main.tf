provider "azurerm" {
  features {}
}

module "Vnet" {
  source = "value"
}