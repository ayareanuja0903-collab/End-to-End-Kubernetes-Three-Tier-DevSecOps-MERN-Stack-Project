module "vpc" {

  source = "./modules/vpc"

  project_name    = var.project_name
  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

}

module "eks" {
  source = "./modules/eks"

  cluster_name    = "${var.project_name}-${var.environment}-eks"
  cluster_version = var.cluster_version

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets

  instance_type = var.instance_type
  desired_size  = var.desired_size
  min_size      = var.min_size
  max_size      = var.max_size

  project_name = var.project_name
  environment  = var.environment

  ebs_csi_role_arn = module.ebs_csi_irsa_role.iam_role_arn

  tags = {
    Terraform   = "true"
    Project     = var.project_name
    Environment = var.environment
  }
}
resource "aws_iam_policy" "cluster_autoscaler" {

  name = "AmazonEKSClusterAutoscalerPolicy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribeInstanceTypes"
        ]

        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {

  policy_arn = aws_iam_policy.cluster_autoscaler.arn

  role = module.eks.eks_managed_node_groups["worker"].iam_role_name

}

################################################################################
# EBS CSI Driver IRSA Role
################################################################################

module "ebs_csi_irsa_role" {

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.50"

  role_name = "${var.project_name}-${var.environment}-ebs-csi-driver"

  attach_ebs_csi_policy = true

  oidc_providers = {

    eks = {

      provider_arn = module.eks.oidc_provider_arn

      namespace_service_accounts = [
        "kube-system:ebs-csi-controller-sa"
      ]
    }
  }

  tags = {
    Terraform   = "true"
    Project     = var.project_name
    Environment = var.environment
  }
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

module "jenkins" {

  source = "./modules/jenkins"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  subnet_id = module.vpc.public_subnets[0]

  instance_type = "t3.medium"

  key_name = var.key_name

}

module "alb_controller" {

  source = "./modules/alb-controller"

  cluster_name = module.eks.cluster_name

  cluster_oidc_provider_arn = module.eks.oidc_provider_arn

  cluster_oidc_issuer_url = module.eks.oidc_provider

  vpc_id = module.vpc.vpc_id

  region = var.aws_region

}

################################################################################
# Helm Repository Initialization
################################################################################

resource "null_resource" "helm_repo_update" {

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]

    command = <<EOT
helm repo add argo https://argoproj.github.io/argo-helm --force-update
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts --force-update
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server --force-update
helm repo add autoscaler https://kubernetes.github.io/autoscaler --force-update
helm repo update
EOT
  }

  triggers = {
    always = timestamp()
  }
}

module "argocd" {
  source = "./modules/argocd"

  namespace = "argocd"

  depends_on = [
    module.eks,
    null_resource.helm_repo_update
  ]
}

module "monitoring" {
  source = "./modules/monitoring"

  cluster_name = module.eks.cluster_name
  namespace    = "monitoring"

  depends_on = [
    module.eks,
    null_resource.helm_repo_update
  ]
}

module "addons" {
  source = "./modules/addons"

  cluster_name = module.eks.cluster_name
  region        = var.aws_region

  depends_on = [
    module.eks,
    null_resource.helm_repo_update
  ]
}