module "eks" {
 source = "terraform-aws-modules/eks/aws"

 cluster_name    = var.cluster_name
 cluster_version = "1.31"

 subnet_ids = module.vpc.private_subnets

 eks_managed_node_groups = {
   workers = {
     desired_size = 2
     min_size     = 2
     max_size     = 4

     instance_types = ["t3.medium"]
   }
 }
}