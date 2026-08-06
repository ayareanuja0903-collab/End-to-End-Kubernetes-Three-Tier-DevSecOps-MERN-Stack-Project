resource "kubernetes_ingress_v1" "argocd" {
  depends_on = [
    helm_release.argocd
  ]

  metadata {
    name      = "argocd-ingress"
    namespace = var.namespace

    annotations = {
      "alb.ingress.kubernetes.io/group.name"       = "three-tier-platform"
      "alb.ingress.kubernetes.io/group.order"      = "20"
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/backend-protocol" = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/argocd/api/version"
      "alb.ingress.kubernetes.io/healthcheck-port" = "80"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      http {

        path {
          path      = "/argocd"
          path_type = "Prefix"

          backend {
            service {
              name = "argocd-server"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}