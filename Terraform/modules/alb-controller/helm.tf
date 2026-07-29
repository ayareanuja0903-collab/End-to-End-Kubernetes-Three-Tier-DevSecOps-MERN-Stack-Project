################################################################################
# AWS Load Balancer Controller Helm Chart
################################################################################

resource "helm_release" "aws_load_balancer_controller" {

  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"

  chart      = "aws-load-balancer-controller"

  namespace  = var.namespace

  version    = var.chart_version

  depends_on = [
    kubernetes_service_account.aws_load_balancer_controller
  ]

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "enableServiceMutatorWebhook"
    value = "true"
  }

  set {
    name  = "replicaCount"
    value = "2"
  }

}