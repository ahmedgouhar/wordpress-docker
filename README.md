WordPress Deployment with Docker & Terraform

An enterprise-grade, automated deployment blueprint for hosting a highly secure and scalable WordPress site. This repository showcases Infrastructure as Code (IaC) using **Terraform**, container orchestration via **Docker Compose**, secure reverse proxying with **Nginx**, automated SSL management via **Certbot**, and continuous deployment using **GitHub Actions**.

---

## 🏗️ Repository Architecture

The project is structured following DevOps and multi-cloud infrastructure best practices:

```text
wordpress-docker/
├── .github/workflows/
│   └── deploy.yml         # GitHub Actions CI/CD deployment pipeline
├── app/
│   ├── nginx/             # Nginx reverse proxy configuration files
│   ├── certbot/           # Let's Encrypt SSL automated generation
│   ├── scripts/           # Automation & maintenance bash scripts
│   └── Dockerfile         # Custom WordPress container build instructions
├── terraform/
│   ├── modules/           # Reusable cloud infrastructure modules (VPC, Compute, DB)
│   ├── .terraform.lock.hcl# Fixed provider version locks
│   ├── main.tf            # Main infrastructure composition
│   ├── provider.tf        # Cloud provider definitions (e.g., AWS)
│   ├── variables.tf       # Input variable definitions
│   └── outputs.tf         # Post-deployment infrastructure outputs
├── .env                   # Local environment variables (Git ignored ⚠️)
└── docker-compose.yml     # Local orchestration for WordPress, DB, and Nginx
🚀 Key Features
Infrastructure as Code (IaC): Modularized Terraform setup for provisioning clean, isolated cloud environments.

Production-Ready Docker Stack: Optimized WordPress and Database multi-container setup.

Secure Reverse Proxy: Nginx integration configured to handle traffic routing and enhance security.

Automated SSL/TLS: Certbot container integration for automated Let's Encrypt certificate issuance and renewal.

CI/CD Automation: GitHub Actions workflow (deploy.yml) to automatically push infrastructure updates and container workloads.

🛠️ Getting Started
Prerequisites
Before you begin, ensure you have the following installed locally:

Docker & Docker Compose

Terraform
 (v1.0+)

Cloud Provider CLI (e.g., AWS CLI) configured with appropriate IAM permissions.

💻 Local Development
To spin up the containerized application stack locally for testing:

Clone the repository:

Bash
git clone [https://github.com/your-username/wordpress-docker.git](https://github.com/your-username/wordpress-docker.git)
cd wordpress-docker
Configure Environment Variables:
Duplicate the template environment file and update your passwords/secrets:

Bash
cp .env.example .env
Note: Never commit your actual .env file to remote version control.

Launch the Stack:

Bash
docker-compose up -d
Your local WordPress instance will be accessible at http://localhost.

☁️ Cloud Infrastructure Deployment (Terraform)
To provision the cloud architecture required to host this setup:

Navigate to the Terraform directory:

Bash
cd terraform
Initialize the workspace and modules:

Bash
terraform init
Review the execution plan:

Bash
terraform plan
Apply and build the infrastructure:

Bash
terraform apply
🤖 CI/CD Pipeline (GitHub Actions)
The .github/workflows/deploy.yml pipeline automates your workflow. Upon pushing to the main branch, the pipeline will:

Lint and validate the Terraform configuration.

Check for security vulnerabilities in the Docker configurations.

Deploy changes securely to the target cloud environment.

Required GitHub Secrets
To make the deployment pipeline work, ensure the following secrets are configured in your GitHub Repository settings:

CLOUD_PROVIDER_CREDENTIALS (e.g., AWS Access Keys)

SSH_PRIVATE_KEY (for secure server access)

ENV_FILE_PRODUCTION (Production secrets for your .env)

🔒 Security & Best Practices
State Locking: Terraform configuration includes automated backend states with dependency locking via .terraform.lock.hcl.

Environment Isolation: Clear segregation between configuration templates and secret runtimes (.env).

Least Privilege: Cloud components are architected using dedicated security groups/firewalls limiting entry strictly to ports 80 and 443.
