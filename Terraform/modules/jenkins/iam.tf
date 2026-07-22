resource "aws_iam_policy" "jenkins_eks_access" {
  name = "three-tier-dev-jenkins-eks-access"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # EKS
      {
        Effect = "Allow"

        Action = [
          "eks:*"
        ]

        Resource = "*"
      },

      # IAM (required for AWS Load Balancer Controller installation)
      {
        Effect = "Allow"

        Action = [
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions",
          "iam:CreateServiceLinkedRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PassRole",
          "iam:TagRole"
        ]

        Resource = "*"
      },

      # STS
      {
        Effect = "Allow"

        Action = [
          "sts:GetCallerIdentity"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_eks_access" {
  role       = aws_iam_role.jenkins.name
  policy_arn = aws_iam_policy.jenkins_eks_access.arn
}
