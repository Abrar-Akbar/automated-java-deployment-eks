# Automated Java Deployment on EKS with Jenkins, SonarQube, Trivy, and ArgoCD

This repository contains the setup and configuration guide for building a Continuous Integration/Continuous Deployment (CI/CD) pipeline for Java applications deployed on an Amazon Elastic Kubernetes Service (EKS) cluster using Jenkins. The pipeline includes integration with SonarQube for static code analysis, Dockerizing the application, scanning Docker images using Trivy, updating build numbers in manifests, and deploying to the EKS cluster through ArgoCD.

## Project Description

Creating a CI/CD pipeline for a Java application to deploy on a Kubernetes cluster using Jenkins is a complex and multi-step process. In this guide, we'll walk through each step in detail, from installing and configuring the necessary tools to deploying the application on Kubernetes. We will also discuss the integration of Jenkins with SonarQube for static code analysis, Dockerizing the application, scanning Docker images using Trivy, then updating build numbers in the manifest and deploying it on the EKS cluster through ArgoCD.

## Workflow Diagram

![image](https://github.com/Abrar-Akbar/automated-java-deployment-eks/assets/62903208/21356ed5-bf96-4640-aa23-0aebd2c53ce3)

## Requirements

### CI/CD Pipeline System

**Pre-requisites:**
- Login to GitHub, Docker Hub, and AWS Accounts
- Launch EC2 instances:
  - Jenkins Master
  - Jenkins Agent
  - EKS Bootstrap server
- Instance types: T2 Micro for Jenkins master and EKS Bootstrap server, T2.medium for Agent
- Security Group: Create a new group with open All traffic (Not recommended in Prod environment, for practice only)
- Default VPC, RAM 15GB

**CI Job Code:** [GitHub Repository](https://github.com/)
**K8s Manifests:** [GitHub Repository](https://github.com/)

## Setup and Configuration

### Jenkins Master Server

1. Update packages and install OpenJDK 17.
2. Install Jenkins.
3. Configure SSH.
4. Generate SSH key and copy to Agent machine.

### Jenkins Agent Machine

1. Update packages and install OpenJDK 17.
2. Install Docker.
3. Configure SSH.
4. Open Jenkins UI, copy initial password and install suggested plugins.
5. Manage Jenkins -> Nodes -> Create a new node.

### Integrate Maven to Jenkins and Add GitHub Credentials

1. Manage Jenkins -> Tools -> Maven installations.
2. Manage Jenkins -> Credentials -> Add GitHub credentials.

### Install and Configure SonarQube

1. Install Docker.
2. Run SonarQube container.
3. Integrate SonarQube with Jenkins.

### Build and Push Docker Image using Pipeline Script

1. Add Docker Hub credentials.
2. Create Jenkins API Token.
3. Create a CI job with a pipeline script from SCM.

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
