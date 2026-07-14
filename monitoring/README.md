# Monitoring Stack - Prometheus, Grafana, Loki & Alertmanager

## Overview

This directory contains the Helm values files used to deploy the monitoring and observability stack for the Three-Tier MERN Stack application running on Amazon EKS.

The monitoring stack provides:

- Prometheus for metrics collection
- Grafana for dashboards and visualization
- Loki for centralized log aggregation
- Promtail for log collection
- Alertmanager for alert routing
- kube-state-metrics for Kubernetes object metrics
- Node Exporter for node-level metrics

---

# Architecture

```text
                        Amazon EKS Cluster
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
  Node Exporter        kube-state-metrics        Promtail
        │                      │                      │
        └────────────── Metrics & Logs ───────────────┘
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
            Prometheus                     Loki
                 │                           │
                 └─────────────┬─────────────┘
                               │
                               ▼
                           Grafana
                               │
                               ▼
                        DevOps Dashboard
```

---

# Folder Structure

```text
Monitoring/
├── README.md
├── prometheus-values.yaml
├── grafana-values.yaml
├── loki-values.yaml
└── alertmanager-values.yaml
```

---

# Prerequisites

Before installing the monitoring stack, ensure:

- Amazon EKS Cluster is running
- kubectl is configured
- Helm is installed
- Metrics Server is installed
- AWS Load Balancer Controller is installed
- StorageClass `gp3` exists

Verify cluster:

```bash
kubectl get nodes
```

Verify Helm:

```bash
helm version
```

---

# Step 1 - Add Helm Repositories

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update
```

---

# Step 2 - Create Namespace

```bash
kubectl create namespace monitoring
```

Verify:

```bash
kubectl get ns
```

---

# Step 3 - Install kube-prometheus-stack

```bash
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f prometheus-values.yaml
```

---

# Step 4 - Install Grafana

```bash
helm install grafana grafana/grafana \
  -n monitoring \
  -f grafana-values.yaml
```

---

# Step 5 - Install Loki

```bash
helm install loki grafana/loki \
  -n monitoring \
  -f loki-values.yaml
```

---

# Step 6 - Install Promtail

```bash
helm install promtail grafana/promtail \
  -n monitoring
```

---

# Verify Installation

```bash
kubectl get pods -n monitoring
```

Expected output:

```text
alertmanager-kube-prometheus-stack-alertmanager
grafana
kube-prometheus-stack-operator
kube-state-metrics
loki
node-exporter
prometheus-kube-prometheus-stack-prometheus
promtail
```

---

# Check Services

```bash
kubectl get svc -n monitoring
```

---

# Access Grafana

If Grafana service is LoadBalancer:

```bash
kubectl get svc grafana -n monitoring
```

Example:

```text
NAME       TYPE           EXTERNAL-IP
grafana    LoadBalancer   a1b2c3.elb.amazonaws.com
```

Open:

```text
http://<GRAFANA_LOADBALANCER>
```

---

# Get Grafana Password

```bash
kubectl get secret grafana \
  -n monitoring \
  -o jsonpath="{.data.admin-password}" | base64 --decode
```

Default username:

```text
admin
```

---

# Access Prometheus

```bash
kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 -n monitoring
```

Open:

```text
http://localhost:9090
```

---

# Access Alertmanager

```bash
kubectl port-forward svc/kube-prometheus-stack-alertmanager 9093:9093 -n monitoring
```

Open:

```text
http://localhost:9093
```

---

# Access Loki

```bash
kubectl get svc -n monitoring
```

Loki will be available internally for Grafana as a data source.

---

# Install Node Exporter (Optional)

```bash
helm install node-exporter prometheus-community/prometheus-node-exporter \
  -n monitoring
```

---

# Useful Commands

### List Helm Releases

```bash
helm list -n monitoring
```

### View Pods

```bash
kubectl get pods -n monitoring
```

### View Services

```bash
kubectl get svc -n monitoring
```

### View Persistent Volumes

```bash
kubectl get pvc -n monitoring
```

### Restart Grafana

```bash
kubectl rollout restart deployment grafana -n monitoring
```

### Restart Prometheus

```bash
kubectl rollout restart statefulset prometheus-kube-prometheus-stack-prometheus -n monitoring
```

---

# Uninstall

Grafana

```bash
helm uninstall grafana -n monitoring
```

Prometheus

```bash
helm uninstall kube-prometheus-stack -n monitoring
```

Loki

```bash
helm uninstall loki -n monitoring
```

Promtail

```bash
helm uninstall promtail -n monitoring
```

---

# Monitoring Workflow

```text
Application Pods
        │
        ▼
Node Exporter
kube-state-metrics
Promtail
        │
        ▼
Prometheus + Loki
        │
        ▼
Grafana Dashboards
        │
        ▼
Alertmanager
        │
        ▼
Slack / Email Alerts (Optional)
```

---

# Tools Used

- Amazon EKS
- Kubernetes
- Helm
- Prometheus
- Grafana
- Loki
- Promtail
- Alertmanager
- Node Exporter
- kube-state-metrics

---

# Related Project Structure

```text
assignment-2june/
│
├── Terraform/
├── kubernetes/
├── helm-charts/
├── argocd/
├── Monitoring/
├── Application-Code/
├── Jenkinsfile-backend
├── Jenkinsfile-frontend
└── README.md
```

---

## Next Phase

After the monitoring stack is deployed, continue with:

**Phase 7 – Logging & Security**

- Trivy
- Falco
- Kyverno
- OWASP Dependency Check
- SonarQube Integration
- Security Policies
- Runtime Threat Detection