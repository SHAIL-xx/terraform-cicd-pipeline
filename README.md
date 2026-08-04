# Infrastructure CI/CD Pipeline with Terraform & LocalStack

![Terraform](https://img.shields.io/badge/Terraform-1.5+-7B42BC?style=flat&logo=terraform&logoColor=white)
![LocalStack](https://img.shields.io/badge/LocalStack-Local_Cloud-0052CC?style=flat&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=flat&logo=github-actions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

An end-to-end Infrastructure as Code (IaC) CI/CD pipeline that automates AWS cloud infrastructure provisioning, linting, validation, and state locking using **Terraform**, **GitHub Actions**, and **LocalStack** for zero-cost local cloud emulation.

---

## 📐 Architecture & Pipeline Workflow

This repository implements a GitOps workflow where infrastructure changes are automatically tested against LocalStack on pull requests and applied when merged into the `main` branch.

```text
[ Developer Push / Pull Request ]
              │
              ▼
┌──────────────────────────────────────────┐
│        GitHub Actions CI Workflow        │
│  1. Spin up LocalStack Docker Container  │
│  2. `terraform fmt -check`               │
│  3. `terraform validate`                 │
│  4. `tflocal plan` (Posts plan to PR)    │
└────────────────────┬─────────────────────┘
                     │
             (Merge to main)
                     │
                     ▼
┌──────────────────────────────────────────┐
│        GitHub Actions CD Workflow        │
│  • `tflocal apply -auto-approve`         │
│  • Emulate S3 Backend & DynamoDB Locking │
└──────────────────────────────────────────┘