terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.16"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }


    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

  }

}