variable "cluster_name" {
  default = "terraform_eks"
  type    = string
}
variable "eks_security_group_ids" {
  type = list(string)

}
variable "eks_subnet_ids" {
  type = list(string)
}

variable "region" {
  description = "define the region"
  type        = string
  default     = "us-west-2"
}

variable "eks_vpc_id" {
  type = string
}

variable "enable_fargate" {
  type        = bool
  description = "Set the number to 1 to enable Fargate"

}

variable "enable_nodegroup" {
  type        = bool
  description = "Set the number to 1 to enable Nodegroup"
}

variable "nodegroup_scaling_config_options" {
  description = "Pass Nodegroup scaling configs for EKS cluster valid only enable_nodegroup is true "
  type        = map(any)
  default = {
    desired_size = 2
    max_size     = 5
    min_size     = 2
  }
}
