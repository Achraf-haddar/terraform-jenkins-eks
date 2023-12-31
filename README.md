# Automated AWS EKS Deployment with Jenkins Pipeline Infrastructure

## Overview

This project automates the creation of a Virtual Private Server (VPS) using Terraform, deploys an EC2 server within the VPS, sets up a Jenkins server on the EC2 instance, and creates a Jenkins pipeline. The Jenkins pipeline is responsible for deploying an Amazon EKS (Elastic Kubernetes Service) cluster and deploying an Nginx application on it.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- Terraform
- Jenkins
- AWS CLI configured with necessary credentials

## Project Structure

- **EKS/:** Terraform configurations for creating the EKS cluster.
- **Jenkins Server/:** Terraform configurations for creating the VPS and EC2 instance with jenkins server setup.
- **Application Configuration Files/:** Nginx server kubernetes manifest files.
- **Jenkinsfile:** for automatic infrastructure (EKS cluster) and application deployment.

## Getting Started

1.  **Clone the repository:**
    `git clone https://github.com/Achraf-haddar/terraform-jenkins-eks.git`
2.  **EC2 and Jenkins Setup:**
    - Navigate to the `Jenkins Server` directory:
    - Initialize Terraform:
      `terraform init`
    - Apply Terraform configurations:
      `terraform apply`
3.  **Jenkins Pipeline:**
    - Create a new pipeline project in Jenkins (access via ec2_instance_public_ip:8080/).
    - Configure the pipeline to use the `Jenkinsfile` provided in the repository.
4.  **Jenkins Pipeline:**
    - Create a new pipeline project in Jenkins.
    - Configure the pipeline to use the `Jenkinsfile` provided in the repository.
5.  **Pipeline Execution:**
    - Trigger the pipeline manually or configure webhooks to automate the pipeline execution.
6.  **You should be able to access the Nginx server via the created Load Balancer**

## Clean Up

To destroy the resources created by Terraform, run:
`terraform destroy`
