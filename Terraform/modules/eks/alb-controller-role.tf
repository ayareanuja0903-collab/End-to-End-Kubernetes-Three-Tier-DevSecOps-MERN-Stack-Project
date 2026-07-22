############################################################
# AWS Load Balancer Controller IRSA Role
############################################################

data "aws_iam_policy_document" "alb_controller_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {

      type = "Federated"

      identifiers = [
        module.eks.oidc_provider_arn
      ]

    }


    condition {

      test = "StringEquals"

      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]

    }

  }

}


resource "aws_iam_role" "aws_load_balancer_controller" {

  name = "aws-load-balancer-controller"

  assume_role_policy = data.aws_iam_policy_document.alb_controller_assume_role.json

}


resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {

  role = aws_iam_role.aws_load_balancer_controller.name

  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn

}


output "aws_load_balancer_controller_role_arn" {

  description = "AWS Load Balancer Controller IAM Role ARN"

  value = aws_iam_role.aws_load_balancer_controller.arn

}