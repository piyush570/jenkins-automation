pipeline {
    agent any 
    environment {
       AWS_ACCESS_KEY_ID = credentials('aws_access_key' )
       AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
       AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("create an EKS Cluster") {
            steps {
                script {
                  dir('eks-cluster') {
                    sh "terraform init"
                    sh "terraform apply --var-file=prod.tfvars"
                  }
                }
            }
        }
        stage("Delploy to EKS") {
            steps {
                script{
                dir('kubernetes')
                 sh "aws eks update-kubeconfig --name my-cluster-tf --region us-east-1"
                 sh "kubectl apply -f deployment.yaml"
                 sh "kubectl apply -f service.yaml"
                }
            }
        }
    }
}
