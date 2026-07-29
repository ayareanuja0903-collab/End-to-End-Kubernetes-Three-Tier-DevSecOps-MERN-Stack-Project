################################################################################
# IAM Policy for AWS Load Balancer Controller
################################################################################

resource "aws_iam_policy" "alb_controller" {
  name        = "${var.cluster_name}-AWSLoadBalancerControllerPolicy"
  description = "IAM policy for AWS Load Balancer Controller"

  policy = file("${path.module}/AWSLoadBalancerControllerIAMPolicy.json")

  tags = var.tags
}

################################################################################
# IAM Role for Service Account (IRSA)
################################################################################

module "alb_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.50"

  role_name = "${var.cluster_name}-aws-load-balancer-controller"

  role_policy_arns = {
    alb = aws_iam_policy.alb_controller.arn
  }

  oidc_providers = {
    eks = {
      provider_arn = var.cluster_oidc_provider_arn

      namespace_service_accounts = [
        "${var.namespace}:${var.service_account_name}"
      ]
    }
  }

  tags = var.tags
}