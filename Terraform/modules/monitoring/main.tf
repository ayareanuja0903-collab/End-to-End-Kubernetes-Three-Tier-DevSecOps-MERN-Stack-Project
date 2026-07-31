resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = var.namespace
  }

}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = true

  values = [
    yamlencode({
      grafana = {
        enabled       = true
        adminUser     = "admin"
        adminPassword = "Admin@123"

        service = {
          type = "ClusterIP"
        }

        persistence = {
          enabled          = true
          storageClassName = "gp2"
          size             = "10Gi"
        }

        grafana = {
          ini = {
            server = {
              root_url            = "%(protocol)s://%(domain)s/grafana/"
              serve_from_sub_path = true
            }
          }
        }
      }
    })
  ]
}