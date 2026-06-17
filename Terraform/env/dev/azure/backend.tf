terraform {
  backend "azurerm" {
    resource_group_name   = "mcp-dev-tfstate-rg"
    storage_account_name  = "mcpdevtfstate"
    container_name        = "tfstate"
    key                   = "dev/azure/terraform.tfstate"
  }
}