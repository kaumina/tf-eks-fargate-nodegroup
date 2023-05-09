
output "eks_vpc_id" {
  description = "Show VPC ID"
  value       = module.networking.vpc_id

}

output "eks_id" {
  description = "Show EKS ID"
  value       = module.eks_cluster.eks_name
}
output "eks_endpoint" {
  description = "Show EKS Endpoint"
  value       = module.eks_cluster.eks_endpoint

}
output "nodegroup_resources_name" {
  description = "Show EKS Node Group Name"
  value       = module.eks_cluster.nodegroup_resources_name
}

