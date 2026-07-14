# Ansible Automation

## Overview

This directory contains Ansible playbooks used to automate the setup of the Jenkins EC2 instance for the End-to-End Kubernetes Three-Tier DevSecOps MERN Stack Project.

## Automated Components

- Common Linux packages
- Docker Engine
- Jenkins
- kubectl
- Helm
- AWS CLI v2
- Trivy Security Scanner
- SonarQube (Docker)

## Project Structure

```text
Ansible/
├── ansible.cfg
├── inventory.ini
├── group_vars/
│   └── all.yml
├── playbooks/
│   ├── common.yml
│   ├── docker.yml
│   ├── jenkins.yml
│   ├── kubectl.yml
│   ├── helm.yml
│   ├── awscli.yml
│   ├── trivy.yml
│   ├── sonarqube.yml
│   ├── prometheus.yml
│   ├── grafana.yml
│   ├── node-exporter.yml
│   └── site.yml
└── README.md
```

## Prerequisites

- Ubuntu EC2 instance
- Ansible installed on the control machine
- SSH access using a private key
- Sudo privileges on the target host

## Verify Connectivity

```bash
ansible all -m ping
```

## Run All Playbooks

```bash
ansible-playbook playbooks/site.yml
```

## Run Individual Playbooks

```bash
ansible-playbook playbooks/docker.yml
ansible-playbook playbooks/jenkins.yml
ansible-playbook playbooks/kubectl.yml
ansible-playbook playbooks/helm.yml
ansible-playbook playbooks/awscli.yml
ansible-playbook playbooks/trivy.yml
ansible-playbook playbooks/sonarqube.yml
```

## Verify Installed Tools

```bash
docker --version
jenkins --version
kubectl version --client
helm version
aws --version
trivy --version
```

## SonarQube

Access SonarQube in your browser:

```
http://<EC2-PUBLIC-IP>:9000
```

Default credentials:

- Username: `admin`
- Password: `admin`

You will be prompted to change the password after the first login.

## Author

Anuja Ayare

End-to-End Kubernetes Three-Tier DevSecOps MERN Stack Project

AWS • Terraform • Jenkins • Docker • Kubernetes • Helm • ArgoCD • Ansible • SonarQube • Trivy • Prometheus • Grafana