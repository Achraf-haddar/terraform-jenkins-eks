pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stage("Checkout SCM") {
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Achraf-haddar/terraform-jenkins-eks.git']])
                }
            }
        }
        stage("Initializing Terraform"){
            steps{
                script{
                    dir("EKS"){
                        sh "terraform init"
                    }
                }
            }
        }
        stage("Formatting Terraform Code"){
            steps{
                script{
                    dir("EKS"){
                        sh "terraform fmt"
                    }
                }
            }
        }
        stage("Validating Terraform"){
            steps{
                script{
                    dir("EKS"){
                        sh "terraform validate"
                    }
                }
            }
        }
        stage("Previewing the Infra using Terraform"){
            steps{
                script{
                    dir("EKS"){
                        sh "terraform plan"
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage("Createing or Destroying an EKS Cluster") {
            steps {
                script {
                    dir("EKS"){
                        sh "terraform $action --auto-approve"
                    }
                }
            }

        }
        stage("Deploying Nginx Application"){
            steps{
                script{
                    dir("Application Configuration Files"){
                        sh "aws eks update-kubeconfig --name eks-cluster"
                        sh "kubectl create -f deployment.yml"
                        sh "kubectl create -f service.yml"
                    }
                }
            }
        }
        
        

    }
}