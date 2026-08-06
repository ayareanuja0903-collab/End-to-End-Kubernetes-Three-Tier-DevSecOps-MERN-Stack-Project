resource "helm_release" "sonarqube" {
  name = "sonarqube"

  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"

  version = "2026.4.0"

  namespace        = "sonarqube"
  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}