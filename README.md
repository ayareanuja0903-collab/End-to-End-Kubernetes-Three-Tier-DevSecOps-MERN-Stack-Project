# 🚀 End-to-End Kubernetes Three-Tier DevSecOps MERN Stack Project on AWS EKS

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge\&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?style=for-the-badge\&logo=amazonaws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=for-the-badge\&logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?style=for-the-badge\&logo=docker)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-D24939?style=for-the-badge\&logo=jenkins)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?style=for-the-badge)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge\&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?style=for-the-badge\&logo=grafana)

---

# 📌 Project Overview

This project demonstrates a **production-style End-to-End DevSecOps implementation** for deploying a **Three-Tier MERN Stack Application** on **Amazon Elastic Kubernetes Service (EKS)**.

The project follows modern DevOps practices including:

* Infrastructure as Code (Terraform)
* Configuration Management (Ansible)
* Containerization (Docker)
* Kubernetes Orchestration
* GitOps using ArgoCD
* CI/CD using Jenkins
* Security Scanning (SonarQube, Trivy, OWASP Dependency-Check)
* Monitoring using Prometheus & Grafana
* AWS ECR for container image storage

---

# 🏗️ Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Webhook
    │
    ▼
Jenkins CI/CD
    │
    ├── Checkout Code
    ├── Build
    ├── Unit Test
    ├── SonarQube Analysis
    ├── OWASP Dependency Check
    ├── Docker Build
    ├── Trivy Scan
    ├── Push Image to AWS ECR
    └── Update Kubernetes Manifest
    │
    ▼
GitHub Repository
    │
    ▼
ArgoCD
    │
    ▼
Amazon EKS
    │
    ├── Frontend
    ├── Backend
    └── MongoDB
    │
    ▼
Prometheus
    │
    ▼
Grafana Dashboards
```

---

# 📁 Project Structure

```text
End-to-End-Kubernetes-Three-Tier-DevSecOps-Project/
│
├── Application-Code/
│   ├── frontend/
│   └── backend/
│
├── Terraform/
│   ├── modules/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
├── kubernetes/
│   ├── frontend/
│   ├── backend/
│   ├── mongodb/
│   ├── ingress/
│   ├── configmap/
│   ├── secrets/
│   ├── networkpolicy/
│   ├── rbac/
│   └── namespace.yaml
│
├── helm-charts/
│
├── ArgoCD/
│
├── Monitoring/
│
├── Ansible/
│
├── Jenkins/
│   ├── Jenkinsfile-Frontend
│   ├── Jenkinsfile-Backend
│   └── scripts/
│
└── README.md
```

---

# 🛠️ Tech Stack

## Cloud

* AWS

## Infrastructure as Code

* Terraform

## Configuration Management

* Ansible

## Containerization

* Docker

## Container Registry

* Amazon ECR

## Container Orchestration

* Kubernetes (Amazon EKS)

## GitOps

* ArgoCD

## CI/CD

* Jenkins

## Code Quality

* SonarQube

## Security

* Trivy
* OWASP Dependency-Check

## Monitoring

* Prometheus
* Grafana
* Node Exporter

## Application

* React.js
* Node.js
* Express.js
* MongoDB

---

# 🚀 Features

* Infrastructure Provisioning with Terraform
* Automated Server Configuration using Ansible
* Dockerized MERN Application
* Kubernetes Deployment on Amazon EKS
* Helm Charts
* GitOps Deployment using ArgoCD
* Jenkins CI/CD Pipelines
* SonarQube Code Analysis
* OWASP Dependency Scanning
* Trivy Container Security Scanning
* AWS ECR Integration
* Horizontal Pod Autoscaler (HPA)
* Network Policies
* RBAC
* ConfigMaps & Secrets
* Persistent Storage for MongoDB
* Prometheus Monitoring
* Grafana Dashboards

---

# ⚙️ Deployment Workflow

1. Developer pushes code to GitHub.
2. GitHub Webhook triggers Jenkins.
3. Jenkins checks out the latest source code.
4. Dependencies are installed.
5. Unit tests and linting are executed.
6. SonarQube performs static code analysis.
7. OWASP Dependency-Check scans project dependencies.
8. Docker images are built.
9. Trivy scans container images.
10. Images are pushed to AWS ECR.
11. Kubernetes deployment manifests are updated.
12. Jenkins commits and pushes manifest changes.
13. ArgoCD detects the changes.
14. ArgoCD synchronizes the application with Amazon EKS.
15. Prometheus collects metrics.
16. Grafana visualizes dashboards.

---

# 📦 Deployment Order

```bash
Terraform

↓

Ansible

↓

Docker Build

↓

Push Images to AWS ECR

↓

Deploy Kubernetes Resources

↓

Deploy Helm Charts

↓

Configure ArgoCD

↓

Configure Jenkins Pipelines

↓

Monitor using Prometheus & Grafana
```

---

# ▶️ Getting Started

## Clone Repository

```bash
git clone https://github.com/ayareanuja0903-collab/End-to-End-Kubernetes-Three-Tier-DevSecOps-MERN-Stack-Project.git
```

---

## Provision Infrastructure

```bash
cd Terraform

terraform init

terraform plan

terraform apply
```

---

## Configure Servers

```bash
cd ../Ansible

ansible-playbook playbooks/site.yml
```

---

## Deploy Kubernetes Resources

```bash
kubectl apply -f kubernetes/
```

---

## Configure ArgoCD

Apply the ArgoCD Application manifests.

---

## Configure Jenkins

* Configure Jenkins credentials
* Install required plugins
* Create Frontend and Backend pipelines
* Configure GitHub Webhooks

---

## Monitoring

Install:

* Prometheus
* Grafana
* Node Exporter

---

# 📊 CI/CD Pipeline

```text
GitHub
   │
   ▼
Jenkins
   │
   ├── Checkout
   ├── Build
   ├── Test
   ├── SonarQube
   ├── OWASP
   ├── Docker Build
   ├── Trivy
   ├── AWS ECR
   ├── Update Manifest
   └── Git Push
   │
   ▼
ArgoCD
   │
   ▼
Amazon EKS
```

---

# 📈 Monitoring Stack

* Prometheus
* Grafana
* Node Exporter

Metrics include:

* CPU Usage
* Memory Usage
* Network Traffic
* Pod Health
* Node Health
* Cluster Performance

---

# 🔐 Security

* Kubernetes RBAC
* Kubernetes Secrets
* Network Policies
* SonarQube Static Analysis
* Trivy Image Scanning
* OWASP Dependency-Check
* Least Privilege Access

---

# 📚 Future Enhancements

* Blue-Green Deployments
* Canary Deployments
* External Secrets Manager
* AWS Load Balancer Controller
* Cluster Autoscaler
* KEDA Autoscaling
* Loki Log Aggregation
* Fluent Bit Log Collection
* Alertmanager Notifications

---

# 👩‍💻 Author

**Anuja Ayare**

DevOps | Cloud | Kubernetes | Terraform | Jenkins | AWS

---

# ⭐ Support

If you found this project helpful:

* ⭐ Star this repository
* 🍴 Fork the repository
* 📢 Share it with others
* 💡 Feel free to contribute
