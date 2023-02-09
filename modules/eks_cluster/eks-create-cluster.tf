#######################################################################################
#             This tf will create EKS cluster
########################################################################################

# Create EKS cluster
resource aws_eks_cluster eks {
  name            = "${var.cluster_name}"
  role_arn        = "${aws_iam_role.eks_cluster.arn}"
  vpc_config {
    security_group_ids = var.eks_security_group_ids
    subnet_ids         = var.eks_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy,
  ]
}