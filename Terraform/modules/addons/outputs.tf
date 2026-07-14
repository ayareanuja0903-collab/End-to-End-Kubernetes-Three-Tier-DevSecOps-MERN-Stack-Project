output "metrics_server_release" {
  value = helm_release.metrics_server.name
}

output "cluster_autoscaler_release" {
  value = helm_release.cluster_autoscaler.name
}

output "cluster_autoscaler_status" {
  value = helm_release.cluster_autoscaler.status
}