pipeline {
    agent any 
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('eks-cluster') {
                        sh "terraform init"
                
                        sh 'terraform destroy -auto-approve --var-file="prod.tfvars"'
                    }
                }
            }
        }
        
    }
}
