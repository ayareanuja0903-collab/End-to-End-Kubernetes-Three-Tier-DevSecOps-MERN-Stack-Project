variable "namespace" {
  description = "ArgoCD Namespace"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "ArgoCD Helm Chart Version"
  type        = string
  default     = "7.7.11"
}

variable "create_namespace" {
  description = "Create Namespace"
  type        = bool
  default     = true
}