# Ansible Configuration Management

## Overview

This Ansible project automates the configuration and deployment of a three-tier web application on AWS. It installs the required software, configures servers, deploys the frontend and backend applications, sets up the database, and configures monitoring tools.

This project is designed to work with infrastructure provisioned by Terraform and can be integrated into a Jenkins CI/CD pipeline.

---

## Project Structure

```text
End-to-End-Kubernetes-Three-Tier-Project/
│
├── Application-Code/
│   ├── backend/
│   └── frontend/
│
├── Terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── ecr/
│   │   ├── jenkins/
│   │   ├── monitoring/
│   │   ├── addons/
│   │   ├── argocd/
│   │   └── argocd_apps/
│   │
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── main.tf
│   └── terraform.tfvars
│
├── Ansible/
│   ├── inventory.ini
│   ├── docker.yml
│   ├── jenkins.yml
│   ├── awscli.yml
│   ├── kubectl.yml
│   ├── helm.yml
│   ├── trivy.yml
│   ├── sonarqube.yml
│   ├── prometheus.yml
│   ├── grafana.yml
│   └── node-exporter.yml
│
├── kubernetes/
│   ├── backend/
│   ├── frontend/
│   ├── mongodb/
│   ├── ingress/
│   ├── namespace/
│   └── storage/
│
├── helm-charts/
│   ├── backend/
│   ├── frontend/
│   └── mongodb/
│
├── monitoring/
│
├── docs/
│
├── scripts/
│
├── Jenkinsfile
├── README.md
└── .gitignore
```

---

## Roles

### Common

* Updates Ubuntu packages
* Installs common utilities
* Configures timezone
* Creates application directories

### Docker

* Installs Docker Engine
* Installs Docker Compose Plugin
* Starts and enables the Docker service
* Adds the Ubuntu user to the Docker group

### Nginx

* Installs Nginx
* Configures reverse proxy
* Serves the frontend application
* Proxies API requests to the backend

### NodeJS

* Installs Node.js 18 LTS
* Installs npm
* Installs PM2 process manager

### Frontend

* Clones the frontend repository
* Installs dependencies
* Builds the React application
* Deploys static files to Nginx

### Backend

* Clones the backend repository
* Installs Node.js dependencies
* Creates the application environment file
* Starts the application using PM2

### MySQL

* Installs MySQL Server
* Creates the application database
* Creates the application user
* Configures remote access

### Monitoring

* Installs Prometheus
* Installs Grafana
* Installs Node Exporter
* Configures monitoring services

---

## Inventory

Update `inventory/hosts.ini` with your EC2 instance IP addresses.

Example:

```ini
[frontend]
frontend-server ansible_host=<FRONTEND_PUBLIC_IP>

[backend]
backend-server ansible_host=<BACKEND_PUBLIC_IP>

[database]
database-server ansible_host=<DATABASE_PUBLIC_IP>

[monitoring]
monitoring-server ansible_host=<MONITORING_PUBLIC_IP>

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/my-key.pem
ansible_python_interpreter=/usr/bin/python3
```

---

## Install Ansible Collections

```bash
ansible-galaxy collection install -r requirements.yml
```

---

## Verify Connectivity

```bash
ansible all -i inventory/hosts.ini -m ping
```

---

## Run Playbooks

Deploy the complete environment:

```bash
ansible-playbook playbooks/site.yml
```

Deploy only the frontend:

```bash
ansible-playbook playbooks/frontend.yml
```

Deploy only the backend:

```bash
ansible-playbook playbooks/backend.yml
```

Deploy only the database:

```bash
ansible-playbook playbooks/database.yml
```

Deploy only monitoring:

```bash
ansible-playbook playbooks/monitoring.yml
```

---

## Prerequisites

* Ubuntu 22.04 or 24.04 EC2 instances
* Python 3 installed
* SSH access to all servers
* Ansible installed on the control node
* AWS infrastructure provisioned using Terraform

---

## Technologies Used

* Ansible
* Ubuntu Linux
* Docker
* Nginx
* Node.js
* PM2
* MySQL
* Prometheus
* Grafana
* AWS EC2

---

## Automation Workflow

1. Terraform provisions AWS infrastructure.
2. Ansible connects to EC2 instances over SSH.
3. Common packages are installed.
4. Docker and runtime dependencies are configured.
5. Frontend and backend applications are deployed.
6. MySQL is configured.
7. Prometheus, Grafana, and Node Exporter are installed.
8. All services are started and enabled.


---

## Author

**Anuja Ayare**

DevOps Engineer | AWS | Terraform | Ansible | Docker | Kubernetes | Jenkins | Prometheus | Grafana
