resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.7.11"
  create_namespace = true

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }

        ingress = {
          enabled = false
        }

        extraArgs = [
          "--insecure"
        ]
      }

      configs = {
        params = {
          "server.insecure" = "true"
          "server.basehref" = "/argocd"
          "server.rootpath" = "/argocd"
        }
      }

      controller = {
        replicas = 1
      }

      repoServer = {
        replicas = 1
      }

      applicationSet = {
        replicas = 1
      }

      redis = {
        enabled = true
      }

      dex = {
        enabled = false
      }

      notifications = {
        enabled = false
      }
    })
  ]
}