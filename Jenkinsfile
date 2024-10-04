pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }


    stages {
        stage('Checkout Code') {
            steps {
                // che
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize the Terraform working directory
                sh 'pwd ;  cd terra-script && terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Generate and display an execution plan
                sh 'cd terra-script && terraform plan' 
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply the Terraform plan automatically
                sh 'cd terra-script && terraform  -auto-approve' 
            }
        }
    }

    post {
        success {
            echo 'Terraform commands executed successfully.'
        }
        failure {
            echo 'Terraform execution failed.'
        }
    }
}
