resource "aws_eks_fargate_profile" "eks_farget_1" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "eks_farget_1"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.eks_subnet_ids

  selector {
    namespace = "default"
  }
}
