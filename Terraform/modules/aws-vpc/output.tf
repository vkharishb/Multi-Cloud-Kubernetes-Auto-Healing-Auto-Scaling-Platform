# Output VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Output public subnets
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

# Output private subnets
output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

# Output NAT gateway IDs
output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = try(module.vpc.natgw_ids, [])
}

# Output VPC CIDR
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Output availability zones
output "azs" {
  description = "List of Availability Zones"
  value       = module.vpc.azs
}
