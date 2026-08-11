variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "three-tier"
}

variable "environment" {
  default = "dev"
}

variable "cluster_version" {
  default = "1.31"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "instance_type" {
  default = "t3.medium"
}

variable "desired_size" {
  default = 2
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}

variable "github_owner" {
  description = "GitHub Username or Organization"
  type        = string
  default     = "ayareanuja0903-collab"
}

variable "github_repository" {
  description = "GitHub Repository Name"
  type        = string
  default     = "End-to-End-Kubernetes-Three-Tier-DevSecOps-MERN-Stack-Project"
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "slack_webhook_url" {
  type      = string
  sensitive = true
}