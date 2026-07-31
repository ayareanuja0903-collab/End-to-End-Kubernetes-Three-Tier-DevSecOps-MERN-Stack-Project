resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = var.namespace
  }

}

resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  namespace        = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  create_namespace = true

  values = [
    yamlencode({
      grafana = {
        adminUser     = "admin"
        adminPassword = "Admin@123"

        "grafana.ini" = {
          server = {
            root_url            = "%(protocol)s://%(domain)s/grafana/"
            serve_from_sub_path = true
          }
        }
      }

      prometheus = {
        prometheusSpec = {
          externalUrl = "http://%(domain)s/prometheus"
          routePrefix = "/prometheus"
        }
      }

      alertmanager = {
        alertmanagerSpec = {
          externalUrl = "http://%(domain)s/alertmanager"
        }
      }
    })
  ]
}