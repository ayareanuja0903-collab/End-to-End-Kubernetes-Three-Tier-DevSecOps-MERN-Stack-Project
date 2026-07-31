variable "namespace" {
  description = "Namespace where SonarQube will be installed"
  type        = string
  default     = "sonarqube"
}


variable "chart_version" {
  description = "SonarQube Helm chart version"
  type        = string
  default     = "10.4.0"
}


variable "alb_group_name" {
  description = "ALB ingress group name"
  type        = string
  default     = "three-tier-platform"
}


variable "alb_scheme" {
  description = "ALB scheme"
  type        = string
  default     = "internet-facing"
}


variable "service_name" {
  description = "SonarQube Kubernetes service name"
  type        = string
  default     = "sonarqube-sonarqube"
}


variable "service_port" {
  description = "SonarQube service port"
  type        = number
  default     = 9000
}