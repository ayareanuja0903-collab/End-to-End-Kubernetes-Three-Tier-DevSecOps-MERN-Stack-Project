resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = var.namespace
  }

}

resource "kubernetes_secret" "slack_webhook" {
  metadata {
    name      = "slack-webhook"
    namespace = "monitoring"
  }

  type = "Opaque"

  data = {
    url = var.slack_webhook_url
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
          routePrefix = "/prometheus"
          externalUrl = "/prometheus"
        }
      }

      alertmanager = {
        alertmanagerSpec = {
          routePrefix = "/alertmanager"
          externalUrl = ""
        }
      }

      kubeStateMetrics = {
        enabled = true
      }

      nodeExporter = {
        enabled = true
      }

      "prometheus-node-exporter" = {
        enabled = true
      }

      cleanupCustomResource = true
    })
  ]
}

resource "kubernetes_manifest" "alertmanager_slack" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1alpha1"
    kind       = "AlertmanagerConfig"

    metadata = {
      name      = "slack-alerts"
      namespace = var.namespace
    }

    spec = {
      route = {
        receiver = "slack"
      }

      receivers = [
        {
          name = "slack"

          slackConfigs = [
            {
              apiURL = {
                name = kubernetes_secret.slack_webhook.metadata[0].name
                key  = "url"
              }

              channel      = "#three-tier-app"
              sendResolved = true

              title = "🚨 Kubernetes Alert"

              text = <<-EOT
                {{ range .Alerts.Firing }}
                *Alert:* {{ .Labels.alertname }}
                *Status:* FIRING
                *Severity:* {{ .Labels.severity }}
                *Summary:* {{ .Annotations.summary }}
                *Description:* {{ .Annotations.description }}
                {{ end }}

                {{ range .Alerts.Resolved }}
                *Alert:* {{ .Labels.alertname }}
                *Status:* RESOLVED
                *Severity:* {{ .Labels.severity }}
                *Summary:* {{ .Annotations.summary }}
                *Description:* {{ .Annotations.description }}
                {{ end }}
              EOT
            }
          ]
        }
      ]
    }
  }

  depends_on = [
    helm_release.kube_prometheus_stack,
    kubernetes_secret.slack_webhook
  ]
}