terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
 
# -----------------------------------
# Get available AZs
# -----------------------------------

data "aws_availability_zones" "available" {}

# -----------------------------------
# VPC
# -----------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "mern-vpc"

  cidr = "10.0.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}


# -----------------------------------
# EKS Cluster
# -----------------------------------

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {

    worker_nodes = {
      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.medium"]

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "production"
    Project     = "MERN-EKS"
  }
}