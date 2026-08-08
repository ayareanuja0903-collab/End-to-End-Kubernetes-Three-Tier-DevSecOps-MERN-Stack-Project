###############################################################################
# ArgoCD
###############################################################################

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
        extraArgs = [
          "--insecure"
        ]
      }

      configs = {
        params = {
          "server.insecure" = "true"
          "server.rootpath" = "/argocd"
        }
      }
    })
  ]
}