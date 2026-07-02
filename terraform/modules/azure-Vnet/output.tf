
output "vnet_id" {
	description = "The ID of the Virtual Network"
	value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
	description = "The name of the Virtual Network"
	value       = azurerm_virtual_network.vnet.name
}

output "resource_group_name" {
	description = "The resource group containing the VNet"
	value       = azurerm_resource_group.rg.name
}

output "location" {
	description = "The location of the Virtual Network"
	value       = azurerm_virtual_network.vnet.location
}

output "address_space" {
	description = "Address spaces of the Virtual Network"
	value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_id" {
	description = "IDs of the created subnets"
	value       = azurerm_subnet.subnets[*].id
}

output "subnet_names" {
	description = "Names of the created subnets"
	value       = azurerm_subnet.subnets[*].name
}

output "route_table_ids" {
	description = "Route table IDs associated with subnets (if any)"
	value       = try(azurerm_subnet.subnets[*].route_table_id, null)
}

output "network_security_group_ids" {
	description = "Network security group IDs associated with subnets (if any)"
	value       = try(azurerm_subnet.subnets[*].network_security_group_id, null)
}

