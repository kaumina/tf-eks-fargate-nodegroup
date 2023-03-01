# Create default Fargate profile
resource "aws_eks_fargate_profile" "eks_farget_main" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "eks_farget_main"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.eks_subnet_ids

  selector {
    namespace = "kube-system"
  }
  selector {
    namespace = "default"
  }
}
