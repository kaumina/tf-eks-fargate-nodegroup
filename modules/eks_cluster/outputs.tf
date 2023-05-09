output "eks_name" {
  value= aws_eks_cluster.eks.id
}

output "eks_endpoint" {
    value = aws_eks_cluster.eks.endpoint
}
output "cert_auth" {
    value =  aws_eks_cluster.eks.certificate_authority.0.data
    
}

output "oidc_url" {
   value = aws_eks_cluster.eks[*].identity.0.oidc.0.issuer
}

output "nodegroup_resources_name" {
   description = "Show EKS Node Group Name"
   value = aws_eks_node_group.eks_node_grp[0].id
  }