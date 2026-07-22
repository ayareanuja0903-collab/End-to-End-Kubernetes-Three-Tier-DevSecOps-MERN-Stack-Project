output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "backend_repository_url" {
  value = module.ecr.backend_repository_url
}

output "mongodb_repository_url" {
  value = module.ecr.mongodb_repository_url
}

output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}

output "argocd_namespace" {
  value = "argocd"
}

output "argocd_release" {
  value = module.argocd.release_name
}

output "jenkins_role_arn" {
  description = "Jenkins IAM Role ARN"
  value       = module.jenkins.jenkins_role_arn
}


############################################################
# AWS Load Balancer Controller IRSA Outputs
############################################################

output "oidc_provider_arn" {

  description = "EKS OIDC Provider ARN"

  value = module.eks.oidc_provider_arn

}


output "cluster_oidc_issuer_url" {

  description = "EKS OIDC Issuer URL"

  value = module.eks.cluster_oidc_issuer_url

}