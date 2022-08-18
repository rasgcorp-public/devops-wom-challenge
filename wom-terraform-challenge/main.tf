terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19"
    }
  }
  backend "s3" {
    bucket = "tf-backend-bucket-poc-wso2-eks"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "iam" {
  source = "./modules/iam"
}

module "network" {
  source = "./modules/network"
}

resource "aws_eks_cluster" "wom_eks" {
  name     = "wom-eks"
  role_arn = module.iam.eks_role_arn

  vpc_config {
    subnet_ids = module.network.vpc_eks_subnets
  }

  depends_on = [
    module.iam,
    module.network
  ]
}

module "iam-ng" {
  source = "./modules/iam-node-group"
}

resource "aws_eks_node_group" "eks_ng" {
  cluster_name    = aws_eks_cluster.wom_eks.name
  node_group_name = "default-ng"
  node_role_arn   = module.iam-ng.eks_ng_role_arn
  subnet_ids      = module.network.vpc_eks_subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    module.iam-ng,
    module.network
  ]
}

