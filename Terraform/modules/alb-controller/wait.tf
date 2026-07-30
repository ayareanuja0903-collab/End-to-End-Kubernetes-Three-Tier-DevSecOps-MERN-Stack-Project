resource "null_resource" "wait_for_alb_controller" {

  depends_on = [
    helm_release.aws_load_balancer_controller
  ]

  provisioner "local-exec" {

    interpreter = ["PowerShell", "-Command"]

    command = <<EOT
kubectl wait deployment/aws-load-balancer-controller `
-n kube-system `
--for=condition=Available `
--timeout=300s
EOT

  }

}