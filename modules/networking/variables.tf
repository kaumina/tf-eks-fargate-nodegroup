variable "cluster_name" {
  default = "terraform_eks"
  type    = string
}
variable "vpc_cidr" {
  default = "10.0.0.16"
  type    = string
}
variable "public_subnets_cidr" {
  type = list(string)

}
variable "private_subnets_cidr" {
  type = list(string)

}
variable "environment" {
  type = string
}