###############################################################################
# ArgoCD Namespace
###############################################################################

resource "kubernetes_namespace" "argocd" {

  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

###############################################################################
# ArgoCD Helm Release
###############################################################################

resource "helm_release" "argocd" {

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"

  chart = "argo-cd"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = false

  wait = true

  timeout = 900

  values = [
    file("${path.module}/argocd-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.argocd
  ]

}