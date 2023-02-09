output "eks_name" {
  value= aws_eks_cluster.eks.id
}

output "eks_endpoint" {
    value = aws_eks_cluster.eks.endpoint
}
output "cert_auth" {
    value =  aws_eks_cluster.eks.certificate_authority.0.data
    
}

