output "vpc_id" {
  description = "Show VPC ID"
  value= aws_vpc.eks_vpc.id
}

output "eks_cluster_sg" {
  description = "Show EKS Cluster Security Group"
  value = aws_security_group.eks_cluster.*.id
}
output "eks_nodes_sg" {
  description = "Show EKS Nodes Security Group"
  value= aws_security_group.eks_node_sg.*.id
}

output "private_subnets" {
  description = "Show VPC Private Subnets"
  value= aws_subnet.private_subnet.*.id
}
