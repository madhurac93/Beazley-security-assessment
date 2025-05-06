# ☁️ Azure 3-Tier Architecture with Terraform

Azure Three tier architecture. The following components are used. Network module creates Vnet, NSG, Subnets. Front door module creates Front door profile and associated routes. AKS module creates the AKS cluster. DB module creates Postgres db with a private endpoint.

- Azure Virtual Network
- Azure Kubernetes Service (AKS)
- PostgreSQL Flexible Server (Private Endpoint)
- Azure Front Door
- Azure Key Vault

---

## 📐 Architecture Overview

```plaintext
          ┌──────────────────────────────┐
          │      Azure Front Door        │
          └────────────┬─────────────────┘
                       │
              ┌────────▼────────┐
              │      AKS        │  ← App Tier
              └────────┬────────┘
                       │
         ┌─────────────▼──────────────┐
         │  PostgreSQL Flexible Server│  ← DB Tier (Private Endpoint)
         └────────────────────────────┘

```


## Module	Purpose
- network	    VNet, subnets, and NSG configuration
- aks	    Deploys Azure Kubernetes Service
- db	    PostgreSQL with private networking
- keyvault    Secrets storage 
- frontdoor   Public ingress with CDN/WAF options


🚀 Getting Started
Prerequisites
Terraform ≥ 1.1.0

Azure CLI (az login)

Azure subscription

Backend storage account (if using remote state)


## Configure Variables
Update terraform.tfvars with your values

## Run terraform
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
