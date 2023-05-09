# Define variables

variable "enable_fargate" {
  description = "Set true to enable Fargate for EKS cluster"
  type        = bool
  default     = false
  validation {
    condition     = var.enable_fargate == true || var.enable_fargate == false
    error_message = "Value must be true or false"
  }
}

variable "enable_nodegroup" {
  description = "Set true to enable Nodegroup for EKS cluster"
  type        = bool
  default     = true
  validation {
    condition     = var.enable_nodegroup == true || var.enable_nodegroup == false
    error_message = "Value must be true or false"
  }
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



