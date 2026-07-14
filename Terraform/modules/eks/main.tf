###############################################################################
# Amazon EKS
###############################################################################

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  control_plane_subnet_ids = var.private_subnets

  enable_irsa = var.enable_irsa

  authentication_mode = "API_AND_CONFIG_MAP"

  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  create_cloudwatch_log_group = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  cluster_addons = {

    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true

      configuration_values = jsonencode({

        env = {

          ENABLE_PREFIX_DELEGATION = "true"

          WARM_PREFIX_TARGET = "1"

        }

      })

    }

    aws-ebs-csi-driver = {

      most_recent = true

    }

  }


  ###############################################################################
  # Managed Node Groups
  ###############################################################################

  eks_managed_node_group_defaults = {

    ami_type = var.ami_type

    instance_types = [
      var.instance_type
    ]

    disk_size = var.disk_size

    capacity_type = var.capacity_type

    update_config = {

      max_unavailable_percentage = 25

    }

  }

  eks_managed_node_groups = {

    worker = {

      name = "worker"

      desired_size = var.desired_size

      min_size = var.min_size

      max_size = var.max_size

      instance_types = [
        var.instance_type
      ]

      capacity_type = var.capacity_type

      ami_type = var.ami_type

      disk_size = var.disk_size

      labels = {

        role = "worker"

      }

      taints = {}

      tags = {

        Name = "${var.cluster_name}-worker"

      }

    }

  }

  ###############################################################################
  # Security Group Rules
  ###############################################################################

  node_security_group_additional_rules = {

    ingress_self_all = {

      description = "Node to node communication"

      protocol = "-1"

      from_port = 0

      to_port = 0

      type = "ingress"

      self = true

    }

    ingress_cluster = {

      description = "Cluster to worker"

      protocol = "-1"

      from_port = 0

      to_port = 0

      type = "ingress"

      source_cluster_security_group = true

    }

    egress_all = {

      description = "Allow all outbound"

      protocol = "-1"

      from_port = 0

      to_port = 0

      type = "egress"

      cidr_blocks = [
        "0.0.0.0/0"
      ]

      ipv6_cidr_blocks = [
        "::/0"
      ]

    }

  }

  ###############################################################################
  # Common Tags
  ###############################################################################

  tags = merge(

    var.tags,

    {

      Project = var.project_name

      Environment = var.environment

      Terraform = "true"

    }

  )
}