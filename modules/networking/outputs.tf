output "vpc_id" {
  value= aws_vpc.eks_vpc.id
}

output "eks_cluster_sg" {
  value = aws_security_group.eks_cluster.*.id
}
output "eks_nodes_sg" {
  value= aws_security_group.eks_node_sg.*.id
}

output "private_subnets" {
  value= aws_subnet.private_subnet.*.id
}
