resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = var.namespace
  }

}

resource "helm_release" "kube_prometheus_stack" {

  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version

  namespace         = var.namespace
  create_namespace  = false
  dependency_update = true

  wait    = true
  timeout = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}