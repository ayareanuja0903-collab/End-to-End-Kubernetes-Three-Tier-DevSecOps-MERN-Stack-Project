resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = var.namespace
  }

}

resource "helm_release" "kube_prometheus_stack" {

  name       = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"

  chart = "kube-prometheus-stack"

  namespace = "monitoring"

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "prometheus.prometheusSpec.externalUrl"
    value = "/prometheus"
  }

  set {
    name  = "prometheus.prometheusSpec.routePrefix"
    value = "/prometheus"
  }

  set {
    name  = "alertmanager.alertmanagerSpec.externalUrl"
    value = "/alertmanager"
  }

  set {
    name  = "alertmanager.alertmanagerSpec.routePrefix"
    value = "/alertmanager"
  }

}