
enable_fargate   = false
enable_nodegroup = true
nodegroup_scaling_config_options = {
  desired_size = 3
  max_size     = 5
  min_size     = 3
}
region       = "us-west-2"
cluster_name = "tf_eks_fargate"
environment  = "POC"