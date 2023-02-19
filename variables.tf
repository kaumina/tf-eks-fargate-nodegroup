variable "region" {
  description = "define the region"
  type        = string
  default     = "us-west-2"
}
variable "cluster_name" {
  default = "tf_eks_fargate"
  type    = string
}
variable "environment" {
  type    = string
  default = "POC"
}