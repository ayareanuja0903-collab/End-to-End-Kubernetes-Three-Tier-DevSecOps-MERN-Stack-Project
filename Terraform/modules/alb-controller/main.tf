locals {
  name = "aws-load-balancer-controller"
}

resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = module.alb_controller_irsa_role.iam_role_arn
    }
  }

  depends_on = [
    module.alb_controller_irsa_role
  ]
}