output "node_group_name" {
  description = "EKS managed node group name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_status" {
  description = "EKS managed node group status"
  value       = aws_eks_node_group.this.status
}