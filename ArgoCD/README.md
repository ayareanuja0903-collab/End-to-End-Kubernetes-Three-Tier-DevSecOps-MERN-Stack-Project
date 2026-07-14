# ArgoCD GitOps Setup

## Overview

This directory contains the ArgoCD configuration for deploying the Three-Tier MERN Stack application on Amazon EKS using GitOps.

ArgoCD continuously monitors this Git repository and automatically synchronizes changes to the Kubernetes cluster.

---

## Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
ArgoCD
    │
    ▼
Helm Charts
    │
    ▼
Amazon EKS
    │
    ├── Frontend
    ├── Backend
    └── MongoDB
```

---

## Folder Structure

```text
argocd/
├── namespace.yaml
├── README.md
└── applications/
    ├── frontend-app.yaml
    ├── backend-app.yaml
    └── mongodb-app.yaml
```

---

## Prerequisites

Before installing ArgoCD, ensure the following are ready:

- AWS EKS Cluster
- kubectl configured
- Helm installed
- AWS CLI configured
- AWS Load Balancer Controller installed

Verify cluster connectivity:

```bash
kubectl get nodes
```

Expected output:

```text
NAME                                           STATUS   ROLES   AGE   VERSION
ip-10-0-1-100.ap-south-1.compute.internal      Ready    <none>  10m   v1.xx.x
```

---

# Installation

## Step 1 – Add Helm Repository

```bash
helm repo add argo https://argoproj.github.io/argo-helm
```

Update Helm repositories:

```bash
helm repo update
```

---

## Step 2 – Create Namespace

```bash
kubectl apply -f namespace.yaml
```

or

```bash
kubectl create namespace argocd
```

---

## Step 3 – Install ArgoCD

```bash
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace
```

---

## Verify Installation

```bash
kubectl get pods -n argocd
```

Expected:

```text
argocd-application-controller      Running
argocd-server                      Running
argocd-repo-server                 Running
argocd-dex-server                  Running
argocd-redis                       Running
```

---

# Access ArgoCD UI

Convert the ArgoCD service to a LoadBalancer:

```bash
kubectl patch svc argocd-server \
  -n argocd \
  -p '{"spec":{"type":"LoadBalancer"}}'
```

Check the external endpoint:

```bash
kubectl get svc -n argocd
```

Example:

```text
argocd-server   LoadBalancer   a1b2c3d4e5.ap-south-1.elb.amazonaws.com
```

Open:

```text
https://<ARGOCD_LOADBALANCER_URL>
```

---

# Get Initial Admin Password

```bash
kubectl get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 --decode
```

Login credentials:

```text
Username: admin
Password: <generated-password>
```

---

# Deploy Applications

Deploy all ArgoCD applications:

```bash
kubectl apply -f applications/
```

---

# Verify Applications

```bash
kubectl get applications -n argocd
```

Expected:

```text
NAME            SYNC STATUS   HEALTH STATUS
frontend-app    Synced        Healthy
backend-app     Synced        Healthy
mongodb-app     Synced        Healthy
```

---

# Force Manual Sync (Optional)

```bash
argocd app sync frontend-app
argocd app sync backend-app
argocd app sync mongodb-app
```

---

# Check Application Details

```bash
argocd app list
```

```bash
argocd app get frontend-app
```

---

# GitOps Workflow

```text
Developer
     │
     ▼
Git Push
     │
     ▼
GitHub Repository
     │
     ▼
ArgoCD detects commit
     │
     ▼
Helm Chart Sync
     │
     ▼
Amazon EKS
     │
     ├── Frontend Updated
     ├── Backend Updated
     └── MongoDB Updated
```

---

# Useful Commands

### Check Pods

```bash
kubectl get pods -n argocd
```

### Check Services

```bash
kubectl get svc -n argocd
```

### Check Applications

```bash
kubectl get applications -n argocd
```

### View Logs

```bash
kubectl logs deployment/argocd-server -n argocd
```

```bash
kubectl logs deployment/argocd-application-controller -n argocd
```

### Restart ArgoCD

```bash
kubectl rollout restart deployment argocd-server -n argocd
```

---

# Troubleshooting

### Applications Not Syncing

```bash
kubectl get applications -n argocd
```

### Check Repository Connectivity

```bash
argocd repo list
```

### Check Cluster Connectivity

```bash
kubectl cluster-info
```

### Restart Controller

```bash
kubectl rollout restart deployment argocd-application-controller -n argocd
```

---

# Tools Used

- Terraform
- AWS EKS
- Kubernetes
- Helm
- ArgoCD
- Jenkins
- Amazon ECR
- Docker
- GitHub

---

# Project Repository Structure

```text
assignment-2june/
│
├── terraform/
├── kubernetes/
├── helm-charts/
├── argocd/
├── monitoring/
├── Application-Code/
├── Jenkinsfile-backend
├── Jenkinsfile-frontend
└── README.md
```

---

## Next Phase

After ArgoCD is configured, continue with:

- **Phase 5 – Monitoring**
  - Prometheus
  - Grafana
  - Node Exporter
  - kube-state-metrics
  - Alertmanager

This completes the GitOps deployment layer of the project.