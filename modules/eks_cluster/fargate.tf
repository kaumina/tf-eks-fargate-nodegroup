# Create Fargate profile for control plane
resource "aws_eks_fargate_profile" "eks_fargate_main" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "eks_fargate_kube_system"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.eks_subnet_ids

  selector {
    namespace = "kube-system"
  }

}
# Create default Fargate profile
resource "aws_eks_fargate_profile" "eks_fargate_default" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "eks_fargate_default"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.eks_subnet_ids

  selector {
    namespace = "default"
  }
}
