output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster control plane"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_admin_role_arn" {
  description = "IAM role ARN for EKS cluster admin access"
  value       = aws_iam_role.eks_admin_role.arn
}