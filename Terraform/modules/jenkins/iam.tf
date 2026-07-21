resource "aws_iam_policy" "jenkins_eks_access" {

  name = "three-tier-dev-jenkins-eks-access"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi"
        ]

        Resource = "*"
      }

    ]

  })
}


resource "aws_iam_role_policy_attachment" "jenkins_eks_access" {

  role = aws_iam_role.jenkins.name

  policy_arn = aws_iam_policy.jenkins_eks_access.arn

}