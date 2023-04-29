# Terraform AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33"
    }
  }
}
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = "DevOps"
    }
  }
}

provider "aws" {
  alias   = "default"
  profile = "default"
  region  = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = "DevOps"
    }
  }
}
module "networking" {
  source               = "./modules/networking"
  cluster_name         = var.cluster_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.5.0/24", "10.0.6.0/24"]
  private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  environment          = "test"


}
module "eks_cluster" {
  source                           = "./modules/eks_cluster"
  cluster_name                     = var.cluster_name
  eks_security_group_ids           = module.networking.eks_cluster_sg
  eks_subnet_ids                   = module.networking.private_subnets
  region                           = var.region
  eks_vpc_id                       = module.networking.vpc_id
  enable_fargate                   = var.enable_fargate
  enable_nodegroup                 = var.enable_nodegroup
  nodegroup_scaling_config_options = var.nodegroup_scaling_config_options


}
