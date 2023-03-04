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