# Demo project

## Overview

This project deploys the Ghost blogging platform on an Azure Kubernetes Service (AKS) cluster using Terraform for infrastructure management and Helm for application deployment. It also includes a directory for Markdown posts which can trigger a CI/CD pipeline to build and deploy the Ghost platform.
Code is located on github repository and github actions is used for CICD part

## Directory Structure
Project code is located in three main folders
  - Infrastructure
  - developer
  - helm-charts

├── infrastructure
│ └── (Terraform code for infrastructure management)
├── developer
│ └── posts
│ ├── my-first-post.md
│ └── (other post files)
├── helm-charts
│ └─ ghost
│ ├── Chart.yaml
│ ├── values.yaml
│ ├── values-dev.yaml
│ ├── values-stg.yaml
│ ├── values-main.yaml
│ ├── templates
│ └── (other chart files)
└── .github
└── workflows
└── ci-cd.yml


### Infrastructure

The `infrastructure` directory contains Terraform code used to set up and manage the Azure resources required for the project. This includes the AKS cluster and any necessary Azure resources like Storage Accounts, Key Vaults, etc.
This is parametarized stucture for dev, stg and main environments. User can deploy Azure resources using his laptop or using gihub actions workflows

#### Terraform Overview

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It allows users to define and provision a datacenter infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL), or optionally JSON.

##### Key Commands

- `terraform init`: Initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration.
- `terraform plan`: Creates an execution plan, showing what actions Terraform will take to reach the desired state defined in the configuration files. It is useful for seeing what changes will be made without actually applying them.
- `terraform apply`: Applies the changes required to reach the desired state of the configuration files. It executes the actions proposed in the `terraform plan`.
- `terraform destroy`: Destroys the infrastructure managed by Terraform. This command is useful for tearing down resources when they are no longer needed.

##### Managing Different Environments

In this project, Terraform is used to manage AKS (Azure Kubernetes Service) deployments across different environments such as development, staging, and production. Each environment can have its own configuration settings, which are managed through separate `values.yaml` files for the Helm charts.

- **Development**: Uses `values-dev.yaml` to define configurations specific to the development environment.
- **Staging**: Uses `values-stg.yaml` to define configurations specific to the staging environment.
- **Production**: Uses `values-main.yaml` to define configurations specific to the production environment.

These configurations ensure that each environment is correctly set up and isolated, providing a robust development workflow and reliable deployment process.

##### Example Usage

To deploy resources using Terraform for a specific environment, you can follow these steps:

1. Initialize Terraform:
    ```sh
    terraform init
    ```

2. Create an execution plan:
    ```sh
    terraform plan -var-file=envs/dev.tfvars
    ```

3. Apply the changes:
    ```sh
    terraform apply -var-file=envs/dev.tfvars
    ```

4. For destroying the resources when they are no longer needed:
    ```sh
    terraform destroy -var-file=envs/dev.tfvars
    ```
#### CICD 
 - `ci-workflow.yml` is pipeline for CI purposes. It is started on pull requests towards dev, stg or main and changes on terraform files in the infrastructure directory. It performs terraform init and terraform plan and provide feedback for the result.
 - `cd-workflow.yml` is pipeline for CD purposes. It is triggered when working branch is dev, stg or main
#### Improvements:
Multi-Region AKS Deployment with Backup and Disaster Recovery

This repository contains Terraform scripts to deploy Azure Kubernetes Service (AKS) clusters across multiple regions to ensure high availability and disaster recovery. The setup includes:

- Primary AKS cluster in West Europe.
- Secondary AKS cluster in North Europe for failover.
- Azure Traffic Manager to distribute traffic between the clusters.
- Backup strategies for stateful data.


### Developer

The `developer` directory contains Markdown files for blog posts. Each Markdown file represents a blog post that will be published on the Ghost platform. When a new post is added or an existing post is updated, a CI/CD pipeline is triggered to build a new Docker image and deploy it to Azure Container Registry (ACR).

### Helm Charts

The `helm-charts` directory contains the Helm chart for deploying the Ghost platform. This chart is pulled from Bitnami and customized for the deployment.

### GitHub Workflows

The `.github/workflows` directory contains GitHub Actions workflows for CI/CD. The `ci-cd.yml` workflow is triggered by changes to the `developer/posts` directory and handles the building and deployment of the Ghost platform.

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Helm](https://helm.sh/docs/intro/install/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure account with appropriate permissions
- Docker

### Setup

1. **Clone the repository:**

   ```sh
   git clone https://github.com/your-username/your-repo.git
   cd your-repo