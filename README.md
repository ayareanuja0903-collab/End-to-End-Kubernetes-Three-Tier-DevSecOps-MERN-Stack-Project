![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge\&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?style=for-the-badge\&logo=amazonaws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=for-the-badge\&logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?style=for-the-badge\&logo=docker)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-D24939?style=for-the-badge\&logo=jenkins)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?style=for-the-badge)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge\&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?style=for-the-badge\&logo=grafana)

<h1>🚀 End-to-End Kubernetes Three-Tier DevSecOps MERN Stack Project on AWS EKS</h1>

---

## Project Overview

Designed and implemented a complete **Three-Tier MERN Stack application deployment** on **Amazon Web Services (AWS)** using modern **DevSecOps** practices. The project automates infrastructure provisioning, CI/CD, GitOps deployment, security scanning, and monitoring for a production-ready Kubernetes environment.

The application consists of a **React frontend**, **Node.js/Express backend**, and **MongoDB database**, deployed on **Amazon EKS** with automated delivery using **Jenkins** and **ArgoCD**. Infrastructure is provisioned using **Terraform**, servers are configured using **Ansible**, and continuous security scanning is integrated through **SonarQube**, **OWASP Dependency Check**, and **Trivy**.

---

# Architecture

```
                      Users
                         │
                  AWS Load Balancer
                         │
                 React Frontend (UI)
                         │
                Node.js / Express API
                         │
                  MongoDB Database
                         │
              Kubernetes Cluster (AWS EKS)
```

---

# Technology Stack

### Cloud
- AWS
- Amazon EKS
- Amazon ECR
- IAM
- VPC
- EC2

### Infrastructure as Code
- Terraform

### Configuration Management
- Ansible

### Containerization
- Docker

### Container Orchestration
- Kubernetes

### CI/CD
- Jenkins
- GitHub Webhooks

### GitOps
- ArgoCD

### Security
- SonarQube
- Trivy
- OWASP Dependency Check

### Monitoring
- Prometheus
- Grafana

### Application Stack
- React.js
- Node.js
- Express.js
- MongoDB

---

# Project Workflow

## 1. Infrastructure Provisioning

Terraform automatically provisions:

- AWS VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- Amazon EKS Cluster
- Managed Node Groups
- Amazon ECR Repositories

---

## 2. Server Configuration

Ansible automates server setup by installing and configuring:

- Docker
- Jenkins
- kubectl
- Helm
- AWS CLI
- Trivy
- Sonar Scanner
- Jenkins Environment

---

## 3. Source Code Management

The GitHub repository contains:

- React Frontend
- Node.js Backend
- MongoDB Configuration
- Kubernetes Manifests
- Jenkins Pipelines
- Terraform Code
- Ansible Playbooks

---

## 4. Continuous Integration (CI)

Whenever code is pushed to GitHub, a webhook automatically triggers Jenkins.

The Jenkins pipeline performs:

- Source Code Checkout
- Dependency Installation
- Application Build
- SonarQube Static Code Analysis
- OWASP Dependency Check
- Trivy Image Scan
- Docker Image Build
- Push Docker Images to Amazon ECR
- Update Kubernetes Manifest with Latest Image Tag
- Commit Updated Manifest to GitHub

---

## 5. Continuous Deployment (CD)

ArgoCD continuously monitors the GitHub repository.

Whenever Kubernetes manifests are updated, ArgoCD automatically:

- Detects Changes
- Synchronizes the Cluster
- Deploys the Latest Version
- Performs Rolling Updates
- Maintains Desired State (GitOps)

No manual deployment is required.

---

## 6. Kubernetes Deployment

The application is deployed on Amazon EKS using:

- Namespace
- Deployments
- Services
- ConfigMaps
- Secrets
- Horizontal Pod Autoscaler (HPA)
- Ingress
- LoadBalancer Service

---

## 7. Security Integration

The project integrates multiple security tools:

- SonarQube for Static Code Analysis
- OWASP Dependency Check for Vulnerability Detection
- Trivy for Container Image Scanning
- Kubernetes Secrets for Sensitive Data
- IAM Roles with Least Privilege Access

---

## 8. Monitoring & Observability

Prometheus collects:

- CPU Usage
- Memory Usage
- Pod Metrics
- Node Metrics
- Application Metrics

Grafana dashboards display:

- Cluster Health
- Pod Status
- CPU & Memory Utilization
- Node Health
- Application Performance

---

# CI/CD Pipeline Flow

```
Developer
     │
     ▼
GitHub Repository
     │
GitHub Webhook
     │
     ▼
Jenkins Pipeline
     │
     ├── Checkout Source Code
     ├── Install Dependencies
     ├── Build Application
     ├── SonarQube Analysis
     ├── OWASP Dependency Check
     ├── Trivy Image Scan
     ├── Docker Build
     ├── Push Image to Amazon ECR
     └── Update Kubernetes Manifest
                │
                ▼
          GitHub Repository
                │
                ▼
              ArgoCD
                │
                ▼
        Amazon EKS Cluster
                │
                ▼
     React + Node.js + MongoDB
```

---

# Key Features

- End-to-End DevSecOps Pipeline
- Infrastructure as Code using Terraform
- Automated Server Configuration using Ansible
- Continuous Integration with Jenkins
- GitOps Deployment using ArgoCD
- Docker Containerization
- Kubernetes Orchestration on Amazon EKS
- Amazon ECR Image Repository
- Automated Security Scanning
- Horizontal Pod Autoscaling
- High Availability Deployment
- Centralized Monitoring using Prometheus & Grafana

---

# Project Outcome

- Automated the complete software delivery lifecycle from infrastructure provisioning to production deployment.
- Reduced manual deployment effort through Infrastructure as Code and GitOps automation.
- Improved deployment consistency, scalability, and reliability using Kubernetes and Amazon EKS.
- Integrated automated security scanning into the CI/CD pipeline to identify code, dependency, and container vulnerabilities early.
- Enabled real-time monitoring and observability using Prometheus and Grafana dashboards.
- Built a production-ready DevSecOps platform following industry best practices.

---

# Skills Demonstrated

- AWS Cloud
- Terraform
- Ansible
- Docker
- Kubernetes
- Amazon EKS
- Amazon ECR
- Jenkins
- GitHub
- GitHub Webhooks
- ArgoCD
- GitOps
- DevSecOps
- SonarQube
- Trivy
- OWASP Dependency Check
- Prometheus
- Grafana
- React.js
- Node.js
- Express.js
- MongoDB
- Linux
- Shell Scripting
- CI/CD Pipeline Design
- Infrastructure Automation

# 👩‍💻 Author

**Anuja Ayare**

DevOps | Cloud | Kubernetes | Terraform | Jenkins | AWS

---
