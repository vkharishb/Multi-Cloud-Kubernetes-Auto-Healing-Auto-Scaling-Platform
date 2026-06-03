ai-auto-healing-platform/

├── README.md

├── terraform/
│   ├── aws/
│   │   ├── eks.tf
│   │   ├── vpc.tf
│   │   └── outputs.tf
│   │
│   └── azure/
│       ├── aks.tf
│       ├── network.tf
│       └── outputs.tf

├── kubernetes/
│   ├── namespaces/
│   ├── ingress/
│   ├── monitoring/
│   ├── autoscaling/
│   ├── security/
│   └── argocd/

├── helm/
│   ├── application/
│   ├── prometheus/
│   ├── grafana/
│   └── loki/

├── auto-healing-controller/
│   ├── app.py
│   ├── healer.py
│   ├── jira.py
│   ├── slack.py
│   ├── kubernetes_client.py
│   ├── requirements.txt
│   └── Dockerfile

├── monitoring/
│   ├── prometheus-rules/
│   ├── grafana-dashboards/
│   └── alerts/

├── argocd/
│   ├── applications/
│   └── projects/

├── github-actions/
│   ├── build.yaml
│   ├── deploy.yaml
│   └── rollback.yaml

└── docs/
    ├── architecture.md
    ├── deployment.md
    └── runbooks/



Users
   |
DNS (Route53 / Azure Traffic Manager)
   |
Ingress Controller
   |
-----------------------------------
| AWS EKS        | Azure AKS      |
-----------------------------------
         |
Microservices
         |
Prometheus
Grafana
Loki
         |
AlertManager
         |
Jira
Slack
Teams
         |
ArgoCD
         |
GitHub Actions
Jenkins