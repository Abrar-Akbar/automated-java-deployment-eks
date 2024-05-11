# Automated Java Deployment on EKS with Jenkins, SonarQube, Trivy, and ArgoCD

This repository contains the setup and configuration guide for building a Continuous Integration/Continuous Deployment (CI/CD) pipeline for Java applications deployed on an Amazon Elastic Kubernetes Service (EKS) cluster using Jenkins. The pipeline includes integration with SonarQube for static code analysis, Dockerizing the application, scanning Docker images using Trivy, updating build numbers in manifests, and deploying to the EKS cluster through ArgoCD.

## Project Description

Creating a CI/CD pipeline for a Java application to deploy on a Kubernetes cluster using Jenkins is a complex and multi-step process. In this guide, we'll walk through each step in detail, from installing and configuring the necessary tools to deploying the application on Kubernetes. We will also discuss the integration of Jenkins with SonarQube for static code analysis, Dockerizing the application, scanning Docker images using Trivy, then updating build numbers in the manifest and deploying it on the EKS cluster through ArgoCD.

## Workflow Diagram

![image](https://github.com/Abrar-Akbar/automated-java-deployment-eks/assets/62903208/21356ed5-bf96-4640-aa23-0aebd2c53ce3)

### Build AWS Infrastructure
- Using terraform
  ```bash
   cd infra-build , terraform init, terraform plan, terraform apply
   ```
## Requirements

### CI/CD Pipeline System

**Pre-requisites:**
- Login to GitHub, Docker Hub, and AWS Accounts
- Launch EC2 instances:
  - Jenkins Master
  - Jenkins Agent
  - EKS Bootstrap server
- Instance types: T2 Micro for Jenkins master and EKS Bootstrap server, T3.medium for Agent
- Security Group: Create a new group with open All traffic (Not recommended in Prod environment, for practice only)
- Default VPC, RAM 20GB

**CI Job Code:** [GitHub Repository](https://github.com/Abrar-Akbar/gitops-register-app-java.git)

## Setup and Configuration

### Jenkins Master Server

1. Update packages and install OpenJDK 17.
2. Install Jenkins.
3. Configure SSH.
4. Generate SSH key and copy to Agent machine.
  ```bash
   sh install_jenkins.sh
   ```
### Jenkins Agent Machine

1. Update packages and install OpenJDK 17.
2. Install Docker.
3. Configure SSH.
4. Open Jenkins UI, copy initial password and install suggested plugins.
 ```bash
  sh install_docker.sh
   ```
```bash
 sh install_trivy.sh
   ```
### Master/Slave configuration

1. Manage Jenkins -> Nodes -> Create a new node -> Number of executors 2
2. Remote root directory: /root/jenkins1 (Any path added but first need to create this dir)
3. Usage: Use this node as much as possible
4. Launch Method: Launch agents via SSH
5. Host: Jenkins-Agent private IP
6. Credentials: add Jenkins (As per your need)
7. Host Key Verification Strategy: non verifying 

### Integrate Maven, and JDK installations to Jenkins and Add GitHub Credentials

1. Manage Jenkins -> Tools -> Maven installations.
2. Name: Maven3, Version: Any choose Install automatically
3. Name: Java17, Install from adoptium.net — Version: Any
4. Manage Jenkins -> Credentials -> Add GitHub credentials
5. kind: Username with password -> Scope: Global -> Username: GitHub username -> password: GitHub password -> id: GitHub

### Install and Configure SonarQube

1. Install Docker.
2. Run SonarQube container.
3. Integrate SonarQube with Jenkins.
...bash
 sh run_sonarqube.sh
   ...
5. Login to sonarqube UI — <Server_public_IP>:9000
6. default credentials: admin/admin -> Go to my account- security — Generate Token — Name: Jenkins sonarqube-token Type: Global analysis token -> Jenkins -> manage Jenkins -> credentials
7. kind: Secret text -> scope: global -> secret : copy token which is generated in sonarqube-token -> ID: jenkins-sonarqube-token
8. Manage Jenkins — system — SonarQube servers- SonarQube installations -> Name: sonarqube-server -> Server URL: -> credentials: token
9. apply and save
10. Manage Jenkins -> Plugins -> Available Plugins -> SonarQube Scanner -> Install
11. Manage Jenkins -> Tools -> SonarQube Scanner installations -> Add SonarQube Scanner -> name: sonarqube-scanner -> tick on -> install automatically -> version: sonarqube scanner 5.0.1.3006
12. apply and save
13.  Manage Jenkins -> system ->  SonarQube servers -> URL: http://<sonarqube_public_IP>:9000
14. Add sonarqube webhook configuration -> Sonarqube -> Administration -> configuration -> webhooks -> create name : sonarqube-webhook -> URL: http://<Jenkins_master_public_IP>:8080/sonarqube-webhook/

### Build and Push Docker Image using Pipeline Script

1. Add Docker Hub credentials.
2. Create Jenkins API Token.
3. Go to Jenkins -> User login -> configure -> API Token -> JENKINS_API_TOKEN
4. Manage Jenkins -> credentials -> Kind: secret text -> Secret: provide token -> ID and description: JENKINS_API_TOKEN -> Save it
5. Create a CI job with a pipeline script from SCM.
  ```bash
   https://github.com/Abrar-Akbar/gitops-register-app-java.git
   ```

### Setup Kubernetes using eksctl (On Bootstrap server)

1. Install AWS CLI, kubectl, and eksctl.
2. Create an IAM Role and assign it to the Bootstrap server.
3. Create a cluster.

### ArgoCD Installation on EKS Cluster and Add EKS Cluster to ArgoCD

1. Create a namespace.
2. Apply ArgoCD yaml configuration files.
3. Deploy CLI and expose argocd-server.
4. Login to ArgoCD, add EKS Cluster.

### Configure ArgoCD to Deploy Pods on EKS and Automate ArgoCD Deployment Job using GitOps GitHub Repository

1. Connect the Git repository to ArgoCD.
2. Create an application in ArgoCD.
3. Access the application.
4. Create a Jenkins CD Job.

## How to Use

- Follow the detailed setup and configuration steps provided in each section above.
- Ensure all prerequisites are met before proceeding with the installation.
- For deployment, trigger the Jenkins CI/CD jobs either manually or remotely using the provided authentication token.
- Monitor the CI/CD pipeline progress through the Jenkins UI and ArgoCD dashboard.
