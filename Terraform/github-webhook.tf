resource "github_repository_webhook" "jenkins" {

  repository = var.github_repository

  active = true

  events = ["push"]

  configuration {
    url          = "http://${module.ec2.jenkins_public_ip}:8080/github-webhook/"
    content_type = "json"
    insecure_ssl = false
  }
}