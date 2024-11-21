

# 🏗️ TerraRun: Automate Your Cloud Run Deployments 🚀

**TerraRun** is a project that automates the deployment of containerized applications to **Google Cloud Run** using **GitHub Actions** and **Terraform**. This guide will help you set up, configure, and deploy your application with ease.  

<img width="960" alt="23" src="https://github.com/user-attachments/assets/0ea0170a-6f8c-4e69-940d-789aca818d32">

---

## 📋 Table of Contents  
1. [✨ Overview](#-overview)  
2. [🌟 Features](#-features)  
3. [🔑 Prerequisites](#-prerequisites)  
4. [⚙️ Setup](#-setup)  
   - [👨‍💻 Local Development](#local-development)  
   - [☁️ Google Cloud Setup](#google-cloud-setup)  
5. [🤖 GitHub Actions Workflow](#-github-actions-workflow)  
6. [🛠️ Terraform Configuration](#-terraform-configuration)  
7. [📦 Usage](#-usage)  
8. [❓ Troubleshooting](#-troubleshooting)  
9. [📚 References](#-references)  

---

## ✨ Overview  

**TerraRun** automates the following:  
| Task                          | Description                                                                                   |
|-------------------------------|-----------------------------------------------------------------------------------------------|
| 🐋 **Dockerization**          | Builds and pushes Docker images to **Google Artifact Registry (GAR)**.                        |
| ☁️ **Cloud Deployment**       | Deploys Docker containers to **Google Cloud Run**.                                   |
| 🔄 **CI/CD Workflow**         | Uses **GitHub Actions** for seamless build and deployment automation.                         |  

---

## 🌟 Features  

- 🔧 **Infrastructure as Code**: Terraform manages the entire infrastructure.  
- 📦 **Containerization**: Leverages Docker for consistent and portable deployments.  
- 🤝 **CI/CD Integration**: GitHub Actions automate the build-deploy pipeline.  
- 🔐 **GCP Integration**: Securely deploys applications on Google Cloud Platform.  

---

## 🔑 Prerequisites  

Ensure you have the following:  

| Requirement                  | Description                                                                                  |
|------------------------------|----------------------------------------------------------------------------------------------|
| 🛠️ **Google Cloud Project** | A GCP project with **Cloud Run** and **Artifact Registry** enabled.                          |
| 🔑 **GCP Credentials**       | A service account key in JSON format with permissions to manage **Cloud Run** and **GAR**.   |
| 🔐 **GitHub Secrets**         | Add the required secrets for the workflow (see below).                                       |
| 🐳 **Docker**                | Installed and running locally for testing and building images.                               |

### 🔐 GitHub Secrets  

| Secret Name       | Description                                                     |
|-------------------|-----------------------------------------------------------------|
| `GCP_CREDS`       | JSON credentials for GCP.                                      |
| `GAR_REGION`      | Region for GAR (e.g., `us-central1`).                           |
| `PROJECT_ID`      | GCP Project ID.                                                |
| `GAR_REPO_NAME`   | Name of the GAR repository.                                     |
| `GAR_IMAGE`       | Name of the Docker image.                                       |
| `GCR_PORT`        | Cloud Run container port (e.g., `8080`).                        |
| `GCR_AUTH`        | Authentication for Cloud Run (`allUsers` or specific account).  |
| `GCR_ROLE`        | IAM role for Cloud Run (`roles/run.invoker`).                   |
| `TF_BUCKET`       | GCS bucket name for storing Terraform state.                    |
| `GCP_REGION`      | Region for GCP services.                                        |

---

## ⚙️ Setup  

### 👨‍💻 Local Development  

1. **Clone the repository**:  
   ```bash  
   git clone https://github.com/your-username/TerraRun.git  
   cd TerraRun  
   ```  

2. **Install dependencies**:  
   ```bash  
   npm install  
   ```  

3. **Ensure Docker is installed and running**.  

---

### ☁️ Google Cloud Setup  

1. Enable the required APIs:  
   - **Cloud Run API**  
   - **Artifact Registry API**  
   - **IAM API**  

2. Create a Google Artifact Registry:  
   ```bash  
   gcloud artifacts repositories create <GAR_REPO_NAME>        --repository-format=docker        --location=<GAR_REGION>        --description="Docker repository for TerraRun"  
   ```  

3. Set up a service account:  
   - Assign the required roles: **Artifact Registry Admin**, **Cloud Run Admin**, and **IAM Admin**.  
   - Generate a JSON key and add it as the `GCP_CREDS` secret in GitHub.  

---

## 🤖 GitHub Actions Workflow  

The workflow automates the CI/CD pipeline:  

| Step                     | Description                                                                                   |
|--------------------------|-----------------------------------------------------------------------------------------------|
| 📦 **Checkout Code**     | Fetches the latest code from the repository.                                                  |
| 🔧 **Setup Node.js**     | Installs Node.js version 20 for the project.                                                  |
| 📂 **Install Dependencies** | Runs `npm install` to install project dependencies.                                           |
| 🔐 **Authenticate to GCP** | Authenticates using the provided service account credentials.                                |
| 🐋 **Build Docker Image** | Builds the Docker image and tags it with the commit SHA.                                      |
| ☁️ **Push to GAR**        | Pushes the Docker image to **Google Artifact Registry**.                                      |
| 🛠️ **Terraform Apply**    | Deploys the Cloud Run service using the Terraform configuration.                             |

---

## 🛠️ Terraform Configuration  

The `main.tf` file manages the infrastructure:  

| Resource                           | Description                                                                                   |
|------------------------------------|-----------------------------------------------------------------------------------------------|
| 🌐 **Cloud Run Service**           | Deploys the Docker image to Cloud Run.                                                        |
| 🔑 **IAM Policy**                  | Configures access control for the Cloud Run service.                                          |
| 📦 **Docker Image Variable**       | Uses the image pushed to GAR for deployment.                                                  |

### 🔧 Variables  

| Variable Name                 | Description                                                          |
|-------------------------------|----------------------------------------------------------------------|
| `TF_VAR_gcp_project_id`       | GCP Project ID.                                                     |
| `TF_VAR_gcp_region`           | GCP Region for deployment.                                          |
| `TF_VAR_cloud_run_location`   | Region for Cloud Run.                                               |
| `TF_VAR_image_name`           | Full path of the Docker image.                                      |
| `TF_VAR_cloud_run_container_port` | Cloud Run container port (e.g., `8080`).                           |
| `TF_VAR_cloud_run_auths`      | Authentication for Cloud Run (`allUsers` or specific account).      |
| `TF_VAR_cloud_run_invoker`    | IAM role for Cloud Run invocation (`roles/run.invoker`).            |

---

## 📦 Usage  

### 🌍 Trigger Deployment  

Push changes to the `master` branch to start the GitHub Actions workflow:  
```bash  
git push origin master  
```  

### 🖥️ Manual Terraform Execution  

1. **Initialize Terraform**:  
   ```bash  
   terraform init        -backend-config="bucket=<TF_BUCKET>"  
   ```  

2. **Apply Terraform Configuration**:  
   ```bash  
   terraform apply -auto-approve  
   ```  

3. **Verify Deployment**:  
   ```bash  
   gcloud run services list  
   ```  

---

## ❓ Troubleshooting  

| Issue                     | Solution                                                                                      |
|---------------------------|-----------------------------------------------------------------------------------------------|
| ❌ **Authentication Error** | Ensure the `GCP_CREDS` secret is correctly configured and matches the GCP JSON key.          |
| 🛠️ **Terraform State Error** | Verify the GCS bucket for Terraform state is properly configured and accessible.              |
| ⚠️ **Deployment Failed**    | Check Cloud Run logs for detailed errors:                                                    |
|                           | ```bash gcloud run services logs read <SERVICE_NAME> ```                                       |

---
## Proof of Concepts

<img width="810" alt="Group 23" src="https://github.com/user-attachments/assets/5ffd8c08-8436-44c1-8094-0c14c2827b23"> <br>

<img width="1301" alt="Group 24" src="https://github.com/user-attachments/assets/506662e3-c6e8-479c-a299-48c4d9a06c0b"><br>

<img width="932" alt="image 5" src="https://github.com/user-attachments/assets/59660f07-dd71-4ca8-8f77-88a6455c2830"><br>

<img width="810" alt="Group 21" src="https://github.com/user-attachments/assets/5de3f582-b069-43e5-9378-662098f847b8"><br>

<img width="1478" alt="Group 22" src="https://github.com/user-attachments/assets/a16450ae-9452-4663-bd7e-1678576a18f2"><br>


---

## 📚 References  

- [📖 Google Cloud Run Documentation](https://cloud.google.com/run/docs)  
- [📖 GitHub Actions Documentation](https://docs.github.com/en/actions)  
- [📖 Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)  

---

Enjoy deploying with **TerraRun**! 🎉

