# Create the Node Role

resource "aws_iam_role" "eks_node_group_role" {
  
  name = "eks_node_group_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_NodeGroup_AmazonEKSWorkerNodePolicy" {
  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_NodeGroup_AmazonEKS_CNI_Policy" {
  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_NodeGroup_AmazonEC2ContainerRegistryReadOnly" {
  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

# Creating the EKS Node Group
resource "aws_eks_node_group" "eks_node_grp" {
  count = var.enable_nodegroup ? 1 : 0
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "default_node_grp"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids = var.eks_subnet_ids
  instance_types = ["t3a.medium"]
  disk_size = 50
  scaling_config {
    desired_size = var.nodegroup_scaling_config_options["desired_size"]
    max_size     = var.nodegroup_scaling_config_options["max_size"]
    min_size     = var.nodegroup_scaling_config_options["min_size"]
  }

  update_config {
    max_unavailable = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_NodeGroup_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_NodeGroup_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_NodeGroup_AmazonEC2ContainerRegistryReadOnly,
  ]
}