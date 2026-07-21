#!/bin/bash
set -euxo pipefail

# Log all output
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

export DEBIAN_FRONTEND=noninteractive

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
    ca-certificates \
    lsb-release

###########################################################
# Install Ansible
###########################################################

apt-get update -y
apt-get install -y ansible

ansible --version

###########################################################
# Install Java 21
###########################################################

apt-get install -y openjdk-21-jdk

java -version

###########################################################
# Install Jenkins
###########################################################

###########################################################
# Install Jenkins (Official 2026 Repository)
###########################################################

mkdir -p /etc/apt/keyrings

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

apt-get update -y

apt-get install -y fontconfig openjdk-21-jre

apt-get install -y jenkins

systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins

sleep 10

systemctl status jenkins --no-pager

###########################################################
# Docker Permissions
###########################################################

usermod -aG docker ubuntu
usermod -aG docker jenkins

###########################################################
# Install AWS CLI v2
###########################################################

cd /tmp

curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o awscliv2.zip

unzip -o awscliv2.zip

./aws/install

aws --version

###########################################################
# Install kubectl
###########################################################

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client

###########################################################
# Install Helm
###########################################################

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

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

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
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
# Jenkins Initial Admin Password
###########################################################

echo "================================================="
echo "Jenkins Initial Admin Password"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "================================================="

###########################################################
# Installation Summary
###########################################################

echo ""
echo "================ Installed Versions ================"
java -version
docker --version
aws --version
kubectl version --client
helm version
ansible --version
node -v
npm -v
trivy --version
git --version
echo "===================================================="

###########################################################
# Completed
###########################################################

echo "Jenkins Server Setup Completed Successfully"