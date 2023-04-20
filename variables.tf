# Define variables

variable "enable_fargate" {
  description = "Set true enable Fargate for EKS cluster"
  type        = bool
  default     = true
}

variable "enable_nodegroup" {
  description = "Set true to enable Nodegroup for EKS cluster"
  type        = bool
  default     = false
}

variable "nodegroup_scaling_config_options" {
  description = "Pass Nodegroup scaling configs for EKS cluster valid only enable_nodegroup is true "
  type        = map(any)
  default = {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-west-2"
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "tf_eks_fargate"
}
variable "environment" {
  description = "The environment applicable"
  type        = string
  default     = "POC"
}



