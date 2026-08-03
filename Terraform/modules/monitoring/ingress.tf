resource "kubernetes_ingress_v1" "monitoring" {
  metadata {
    name      = "monitoring-ingress"
    namespace = "monitoring"

    annotations = {
      "alb.ingress.kubernetes.io/group.name"   = "three-tier-platform"
      "alb.ingress.kubernetes.io/group.order"  = "10"
      "alb.ingress.kubernetes.io/scheme"       = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"  = "ip"
      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80}]"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      http {
        path {
          path      = "/prometheus"
          path_type = "Prefix"

          backend {
            service {
              name = "kube-prometheus-stack-prometheus"

              port {
                number = 9090
              }
            }
          }
        }

        path {
          path      = "/alertmanager"
          path_type = "Prefix"

          backend {
            service {
              name = "kube-prometheus-stack-alertmanager"

              port {
                number = 9093
              }
            }
          }
        }

        path {
          path      = "/grafana"
          path_type = "Prefix"

          backend {
            service {
              name = "kube-prometheus-stack-grafana"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.kube_prometheus_stack
  ]
}