# Output the EKS cluster endpoint
output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks_cluster.cluster_endpoint
}

# Output the EKS cluster name
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

# Output the EKS cluster version
output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = module.eks_cluster.cluster_version
}

# Output the cluster security group ID
output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks_cluster.cluster_security_group_id
}

# Output the managed node group IDs
output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.eks_cluster.eks_managed_node_groups
}

# Output cluster ARN
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks_cluster.cluster_arn
}

# Output OIDC provider ARN
output "oidc_provider_arn" {
  description = "ARN of the OIDC Provider for EKS"
  value       = try(module.eks_cluster.oidc_provider_arn, null)
}
