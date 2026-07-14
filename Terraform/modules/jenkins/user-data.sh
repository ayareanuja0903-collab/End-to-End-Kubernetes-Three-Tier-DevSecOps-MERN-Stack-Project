#!/bin/bash
set -euxo pipefail

# Log all output
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

###########################################################
# Update System
###########################################################

apt-get update -y
apt-get upgrade -y

###########################################################
# Install Required Packages
###########################################################

apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    gnupg \
    software-properties-common \
    apt-transport-https \
    ca-certificates

###########################################################
# Install Java 21
###########################################################

apt-get install -y openjdk-21-jdk

java -version

###########################################################
# Install Jenkins
###########################################################

wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

###########################################################
# Install Docker
###########################################################

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
> /etc/apt/sources.list.d/docker.list

apt-get update -y

apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

systemctl enable docker
systemctl start docker

###########################################################
# Docker Permissions
###########################################################

usermod -aG docker ubuntu
usermod -aG docker jenkins

###########################################################
# Install AWS CLI v2
###########################################################

cd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o awscliv2.zip

unzip awscliv2.zip

./aws/install

aws --version

###########################################################
# Install kubectl
###########################################################

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client

###########################################################
# Install Helm
###########################################################

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

###########################################################
# Install Node.js 22 LTS
###########################################################

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

apt-get install -y nodejs

node -v
npm -v

###########################################################
# Install Trivy
###########################################################

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
| gpg --dearmor \
-o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb generic main" \
> /etc/apt/sources.list.d/trivy.list

apt-get update -y

apt-get install -y trivy

trivy --version

###########################################################
# Restart Services
###########################################################

systemctl restart docker
systemctl restart jenkins

###########################################################
# Jenkins Password
###########################################################

echo "================================================="
echo "Jenkins Initial Admin Password"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "================================================="

###########################################################
# Completed
###########################################################

echo "Jenkins Server Setup Completed Successfully"