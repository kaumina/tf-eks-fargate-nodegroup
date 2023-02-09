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
  profile = "default"
  region  = var.region
  default_tags {
    tags = {
      Environment = "Test"

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
  source                 = "./modules/eks_cluster"
  cluster_name           = var.cluster_name
  eks_security_group_ids = module.networking.eks_cluster_sg
  eks_subnet_ids         = module.networking.private_subnets

}

/*
resource "null_resource" "this" {
  provisioner "local_exec" {
    command = "aws eks update_kubeconfig __region $REGION __name $CLUSTER_NAME"
    environment = {
      REGION = var.region
      CLUSTER_NAME = var.cluster_name
      
    }

  }
}
*/