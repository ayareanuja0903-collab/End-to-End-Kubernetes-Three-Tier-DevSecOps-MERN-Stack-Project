###############################################################################
# Cluster
###############################################################################

variable "cluster_name" {
  description = "Amazon EKS Cluster Name"
  type        = string
}

variable "cluster_oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC Issuer URL"
  type        = string
}

###############################################################################
# Networking
###############################################################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

###############################################################################
# Namespace
###############################################################################

variable "namespace" {
  description = "Namespace for AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "Service Account Name"
  type        = string
  default     = "aws-load-balancer-controller"
}

###############################################################################
# Helm
###############################################################################

variable "chart_version" {
  description = "AWS Load Balancer Controller Helm Chart Version"
  type        = string
  default     = "1.11.0"
}

###############################################################################
# Tags
###############################################################################

variable "tags" {
  description = "Common Tags"
  type        = map(string)

  default = {
    Terraform = "true"
    Project   = "three-tier"
  }
}