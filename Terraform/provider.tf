provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path = "C:/Users/DELL/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "C:/Users/DELL/.kube/config"
  }
}

provider "kubectl" {
  config_path      = "C:/Users/DELL/.kube/config"
  load_config_file = true
}

provider "null" {}