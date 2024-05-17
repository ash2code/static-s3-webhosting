pipeline {
    agent any 

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
        TERRAFORM_DESTROY = 'no'
    }
    stages { 
        stage('git-checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ash2code/static-s3-webhosting.git'
            }
        }
        stage('terraform-init') {
            steps {
                script {
                    sh "terraform init"
                }
            }
        }
        stage('terraform-plan') {
            steps {
                script {
                    sh "terraform plan"
                }
            }
        }
        stage('terraform-apply') {
            steps {
                script {
                    sh "terraform apply --auto-approve"
                }
            }
        }
        stage('trraform-destroy') {
            steps {
                script {
                    if (env.TERRAFORM_DESTROY = 'ye') {
                        sh "terraform destroy --auto-approve"
                    }
                    else
                    {
                        echo "skipping terraform destroy as terraform destroy set to no"
                    }
                }
            }
        }
    }
}
           

