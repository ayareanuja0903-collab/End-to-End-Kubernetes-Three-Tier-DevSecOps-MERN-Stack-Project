############################################################
# Metrics Server
############################################################

resource "helm_release" "metrics_server" {

  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server"

  chart = "metrics-server"

  version = var.metrics_server_version

  namespace = "kube-system"

  create_namespace = false

  wait = true

  timeout = 600

}

############################################################
# Cluster Autoscaler
############################################################

resource "helm_release" "cluster_autoscaler" {

  name = "cluster-autoscaler"

  repository = "https://kubernetes.github.io/autoscaler"

  chart = "cluster-autoscaler"

  version = var.cluster_autoscaler_version

  namespace = "kube-system"

  wait = true

  timeout = 600

  values = [

    <<EOF
autoDiscovery:
  clusterName: ${var.cluster_name}

awsRegion: ${var.region}

rbac:
  create: true
EOF

  ]

}