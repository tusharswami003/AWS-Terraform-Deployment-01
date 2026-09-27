output "vpc_id" {
  description = "Test VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"

  value = [
    module.subnet.subnet_ids["public-a"],
    module.subnet.subnet_ids["public-b"]
  ]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"

  value = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.nat_gateway.nat_gateway_id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "eks_node_group_name" {
  description = "EKS managed node group name"
  value       = module.eks_node_group.node_group_name
}

output "eks_node_group_status" {
  description = "EKS managed node group status"
  value       = module.eks_node_group.node_group_status
}

output "eks_cluster_role_arn" {
  description = "IAM role used by EKS control plane"
  value       = module.eks_cluster_role.role_arn
}

output "eks_node_role_arn" {
  description = "IAM role used by EKS worker nodes"
  value       = module.eks_node_role.role_arn
}