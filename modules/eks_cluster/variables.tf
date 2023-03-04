variable "cluster_name" {
  default = "terraform_eks"
  type    = string
}
variable "eks_security_group_ids" {
  type    = list(string)
   
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
 type        = string 
}