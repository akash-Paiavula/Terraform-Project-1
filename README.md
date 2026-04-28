# 🏗️ Production-Grade AWS 3-Tier Architecture — Security & Monitoring

![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![CloudWatch](https://img.shields.io/badge/CloudWatch-FF4F8B?style=for-the-badge&logo=amazonaws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

> **Highly available, secure, production-grade 3-tier AWS architecture with DevSecOps controls, real-time monitoring, and full Infrastructure as Code — achieving 99.9% uptime**

---

## 📌 Problem Statement

Building cloud applications that are truly production-ready requires more than just deploying code — it requires high availability, automated scaling, security controls, and real-time monitoring. This project implements a complete 3-tier AWS architecture with all of these built in from the ground up, provisioned entirely via Terraform.

---

## 🏗️ Architecture

```
                        Internet
                            │
                            ▼
                ┌───────────────────────┐
                │     AWS CloudFront    │  ← CDN + DDoS Protection
                │     + WAF Rules       │  ← IP allowlisting, geo-restriction
                └───────────┬───────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                    PUBLIC SUBNET                          │
│                                                          │
│         ┌─────────────────────────────────┐              │
│         │   Application Load Balancer     │              │
│         │   (ALB) — HTTPS via ACM/TLS     │              │
│         └────────────────┬────────────────┘              │
└──────────────────────────┼───────────────────────────────┘
                           │
┌──────────────────────────┼───────────────────────────────┐
│                  PRIVATE SUBNET (APP)                     │
│                           │                              │
│         ┌─────────────────▼────────────────┐             │
│         │      Auto Scaling Group          │             │
│         │      EC2 Instances               │             │
│         │      (Application Tier)          │             │
│         └─────────────────┬────────────────┘             │
└──────────────────────────┼───────────────────────────────┘
                           │
┌──────────────────────────┼───────────────────────────────┐
│                  PRIVATE SUBNET (DB)                      │
│                           │                              │
│         ┌─────────────────▼────────────────┐             │
│         │   Amazon RDS (Multi-AZ)          │             │
│         │   (Database Tier)                │             │
│         └──────────────────────────────────┘             │
└──────────────────────────────────────────────────────────┘
                           │
              ┌────────────▼────────────┐
              │   CloudWatch + SNS +    │  ← Real-time monitoring
              │   Lambda Alerting       │  ← Automated incident response
              └─────────────────────────┘
```

---

## ✅ Key Features

### 🔒 Security (DevSecOps)
- **AWS WAF** — IP allowlisting, geo-restriction, OWASP Top 10 rule sets
- **HTTPS/TLS** — End-to-end encryption via AWS Certificate Manager (ACM)
- **VPC Segmentation** — Public/private subnets, Security Groups, NACLs
- **IAM least-privilege** — Minimal permissions for each service and role

### 📈 High Availability
- **Multi-AZ RDS** — Automatic database failover across availability zones
- **Auto Scaling Groups** — Dynamic EC2 scaling based on CPU/memory load
- **Application Load Balancer** — Health checks + traffic distribution across instances
- **CloudFront CDN** — Global edge caching for low latency

### 📊 Monitoring & Alerting
- **CloudWatch** — Real-time metrics, custom dashboards, log groups
- **SNS + Lambda** — Automated alerting pipeline for threshold breaches
- **Automated incident response** — Lambda triggers remediation actions on alerts

### 🏗️ Infrastructure as Code
- **100% Terraform** — Every resource provisioned programmatically, zero manual clicks
- **Modular design** — Separate modules for networking, compute, database, security
- **State management** — Remote state in S3 with DynamoDB locking

---

## 📊 Results & Impact

| Metric | Result |
|--------|--------|
| Uptime target | ✅ **99.9%** achieved |
| Security threats blocked | WAF blocks Layer 7 attacks in real-time |
| MTTR (Mean Time to Recovery) | ⬇️ Significantly reduced via automated alerting |
| Infrastructure deployment time | < 15 minutes (full stack via `terraform apply`) |
| Manual infrastructure steps | **Zero** — fully IaC |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| CDN & WAF | AWS CloudFront + AWS WAF |
| Load Balancing | AWS Application Load Balancer (ALB) |
| Compute | AWS EC2 + Auto Scaling Groups |
| Database | AWS RDS (MySQL, Multi-AZ) |
| Storage | AWS S3 |
| TLS/SSL | AWS Certificate Manager (ACM) |
| Monitoring | AWS CloudWatch + SNS + Lambda |
| IaC | Terraform |
| Configuration | Ansible |
| DNS | AWS Route 53 |
| Scripting | Python, Bash |

---

## 🚀 Deployment

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform v1.0+ installed
- Domain name (for ACM certificate)

### 1. Clone repository
```bash
git clone https://github.com/akash-Paiavula/Terraform-Project-1.git
cd Terraform-Project-1
```

### 2. Configure variables
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values:
# - AWS region
# - Domain name
# - Database credentials (use AWS Secrets Manager in production)
# - CIDR blocks
```

### 3. Deploy infrastructure
```bash
terraform init
terraform plan       # Review what will be created
terraform apply      # Deploy everything
```

### 4. Verify deployment
```bash
# Check all resources
terraform output

# Test the load balancer
curl https://your-domain.com/health

# View CloudWatch dashboard
aws cloudwatch list-dashboards
```

### 5. Destroy when done
```bash
terraform destroy    # Clean up all resources
```

---

## 📁 Repository Structure

```
├── modules/
│   ├── networking/         # VPC, subnets, route tables, NACLs
│   ├── security/           # Security groups, WAF, ACM, IAM
│   ├── compute/            # EC2, Auto Scaling Groups, ALB
│   ├── database/           # RDS Multi-AZ
│   ├── cdn/                # CloudFront distribution
│   └── monitoring/         # CloudWatch, SNS, Lambda
├── environments/
│   ├── dev/
│   └── prod/
├── scripts/
│   ├── health-check.py
│   └── alert-handler.py    # Lambda function for alerting
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── README.md
```

---

## 🔐 Security Controls Implemented

| Control | Implementation |
|---------|---------------|
| DDoS Protection | AWS WAF + CloudFront |
| Network Isolation | VPC with public/private subnets |
| Encryption in Transit | ACM/TLS on all tiers |
| Encryption at Rest | RDS encryption + S3 SSE |
| Access Control | IAM roles + Security Groups + NACLs |
| Vulnerability Protection | WAF OWASP Top 10 managed rules |
| Audit Logging | CloudTrail + CloudWatch Logs |

---

## 📚 What I Learned

- Designing highly available multi-tier AWS architectures
- WAF rule configuration for real-world threat mitigation
- Terraform module design patterns for production IaC
- CloudWatch metric filters and automated alerting pipelines
- Multi-AZ RDS configuration for database resilience
- ACM certificate management and HTTPS enforcement

---

## 👤 Author

**Akash Paiavula**
- 📧 akashpaiavula2003@gmail.com
- 💼 [LinkedIn](https://linkedin.com/in/akash-paiavula-a68718289)
- 🐙 [GitHub](https://github.com/akash-Paiavula)

---

⭐ **If this project helped you, please give it a star!**
