output "sonarqube_namespace" {

  description = "SonarQube namespace"

  value = var.namespace

}


output "sonarqube_service" {

  description = "SonarQube Kubernetes service"

  value = var.service_name

}


output "sonarqube_url_path" {

  description = "SonarQube ALB path"

  value = "/sonarqube"

}