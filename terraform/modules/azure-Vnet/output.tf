output "vnet_id" {
  value = module.Vnet.vnet_id
}

output "vnet_name" {
  value = module.Vnet.vnet_name
}

output "subnet_ids" {
  value = module.Vnet.vnet_subnets
}

output "aks_subnet_id" {
  value = module.Vnet.vnet_subnets[0]
}