pipeline {
    agent any 

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
    }
}
