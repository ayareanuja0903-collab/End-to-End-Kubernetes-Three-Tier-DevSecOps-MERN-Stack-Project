output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}



output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}
output "oidc_provider_arn" {

  description = "OIDC Provider ARN"

  value = module.eks.oidc_provider_arn

}


output "oidc_provider" {

  description = "OIDC Provider URL"

  value = module.eks.oidc_provider

}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}

output "eks_managed_node_groups" {
  value = module.eks.eks_managed_node_groups
}

