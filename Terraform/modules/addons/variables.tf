variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "metrics_server_version" {
  description = "Metrics Server Helm Chart Version"
  type        = string
  default     = "3.12.2"
}

variable "cluster_autoscaler_version" {
  description = "Cluster Autoscaler Helm Chart Version"
  type        = string
  default     = "9.37.0"
}