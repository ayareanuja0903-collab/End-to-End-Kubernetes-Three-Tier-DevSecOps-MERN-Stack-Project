resource "kubernetes_ingress_v1" "sonarqube" {

  metadata {
    name      = "sonarqube-ingress"
    namespace = "sonarqube"

    annotations = {

      "alb.ingress.kubernetes.io/group.name" = "three-tier-platform"
      "alb.ingress.kubernetes.io/group.order" = "1"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80}]"

      "alb.ingress.kubernetes.io/backend-protocol" = "HTTP"

      "alb.ingress.kubernetes.io/healthcheck-path" = "/sonarqube/api/system/status"

      "alb.ingress.kubernetes.io/success-codes" = "200"
    }
  }


  spec {

    ingress_class_name = "alb"


    rule {

      http {

        path {

          path = "/sonarqube/"

          path_type = "Prefix"


          backend {

            service {

              name = "sonarqube-sonarqube"

              port {
                number = 9000
              }

            }

          }

        }

      }

    }

  }


  depends_on = [
    helm_release.sonarqube
  ]
}