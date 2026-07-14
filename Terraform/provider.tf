terraform {

  required_version = ">= 1.6"

}


###########################################################
# AWS Provider
###########################################################

provider "aws" {

  region = var.aws_region

}



###########################################################
# EKS Cluster Data
###########################################################

data "aws_eks_cluster" "cluster" {

  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]

}


data "aws_eks_cluster_auth" "cluster" {

  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]

}



###########################################################
# Kubernetes Provider
###########################################################

provider "kubernetes" {

  host = data.aws_eks_cluster.cluster.endpoint


  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.cluster.certificate_authority[0].data
  )


  token = data.aws_eks_cluster_auth.cluster.token

}



###########################################################
# Helm Provider
###########################################################

provider "helm" {

  kubernetes {

    host = data.aws_eks_cluster.cluster.endpoint


    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.cluster.certificate_authority[0].data
    )


    token = data.aws_eks_cluster_auth.cluster.token

  }

}



###########################################################
# Kubectl Provider
###########################################################

provider "kubectl" {

  host = data.aws_eks_cluster.cluster.endpoint


  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.cluster.certificate_authority[0].data
  )


  token = data.aws_eks_cluster_auth.cluster.token


  load_config_file = false

}