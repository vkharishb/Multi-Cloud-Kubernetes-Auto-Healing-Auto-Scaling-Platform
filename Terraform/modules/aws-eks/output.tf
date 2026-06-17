output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks_cluster.cluster_endpoint
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks_cluster.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster CA data"
  value       = module.eks_cluster.cluster_certificate_authority_data
  sensitive   = true
}

output "node_security_group_id" {
  description = "EKS node security group ID"
  value       = module.eks_cluster.node_security_group_id
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.eks_cluster.cluster_security_group_id
}