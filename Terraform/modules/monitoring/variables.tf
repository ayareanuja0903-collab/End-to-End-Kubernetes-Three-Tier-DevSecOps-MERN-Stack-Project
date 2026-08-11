variable "cluster_name" {

  description = "EKS Cluster Name"

  type = string

}


variable "namespace" {

  description = "Monitoring Namespace"

  type = string

  default = "monitoring"

}


variable "chart_version" {

  description = "kube-prometheus-stack version"

  type = string

  default = "69.5.2"

}

variable "slack_webhook_url" {
  type      = string
  sensitive = true
}