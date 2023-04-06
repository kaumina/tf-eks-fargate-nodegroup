#######################################################################################
#             Creating EKS cluster
########################################################################################

# Create EKS cluster
resource aws_eks_cluster eks {
  name            = "${var.cluster_name}"
  role_arn        = "${aws_iam_role.eks_cluster.arn}"
  enabled_cluster_log_types = ["api", "audit"]
  vpc_config {
    security_group_ids = var.eks_security_group_ids
    subnet_ids         = var.eks_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.cluster_cw_log_grp,
  ]
}

# Creating CloudWatch log group for enabling EKS Logs
resource "aws_cloudwatch_log_group" "cluster_cw_log_grp" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

}