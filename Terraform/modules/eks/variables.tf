variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes Version"
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnet IDs"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "Worker Node Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "desired_size" {
  description = "Desired Worker Nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum Worker Nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum Worker Nodes"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Node Root Volume Size"
  type        = number
  default     = 30
}

variable "capacity_type" {
  description = "Node Capacity Type"
  type        = string
  default     = "ON_DEMAND"
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Enable Public API Endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Enable Private API Endpoint"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)

  default = {
    Terraform = "true"
    Project   = "three-tier"
  }
}

variable "cluster_addons" {
  description = "EKS Cluster Addons"

  type = map(any)

  default = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true
    }

    aws-ebs-csi-driver = {
      most_recent = true
    }
  }
}

variable "ami_type" {
  description = "AMI Type"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Cluster Creator Admin Access"
  type        = bool
  default     = true
}

variable "ebs_csi_role_arn" {
  description = "IAM Role ARN for EBS CSI Driver"
  type        = string
}