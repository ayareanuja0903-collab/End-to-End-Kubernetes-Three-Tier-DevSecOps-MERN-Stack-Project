output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "public_dns" {
  value = aws_instance.jenkins.public_dns
}

output "security_group_id" {
  value = aws_security_group.jenkins.id
}

output "instance_profile" {
  value = aws_iam_instance_profile.jenkins.name
}

output "jenkins_security_group_id" {
  description = "Jenkins Security Group ID"
  value       = aws_security_group.jenkins.id
}
output "jenkins_role_arn" {
  description = "Jenkins IAM Role ARN"
  value       = aws_iam_role.jenkins.arn
}