resource "helm_release" "sonarqube" {
  name = "sonarqube"

  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"

  version = "2026.4.0"

  namespace        = "sonarqube"
  create_namespace = true

  wait          = true
  wait_for_jobs = true
  timeout       = 900
  atomic        = true

  values = [
    file("${path.module}/values.yaml")
  ]
}