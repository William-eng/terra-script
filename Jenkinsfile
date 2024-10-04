pipeline {
    agent any

    stages {
        stage('Install Terraform') {
            steps {
                sh '''
                wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
                unzip terraform_1.6.0_linux_amd64.zip
                sudo mv terraform /usr/local/bin/
                '''
            }
        }

        stage('Checkout Code') {
            steps {
                // che
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize the Terraform working directory
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Generate and display an execution plan
                sh 'terraform plan' 
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'  // Only apply the changes on the 'main' branch
            }
            steps {
                // Apply the Terraform plan automatically
                sh 'terraform apply -auto-approve' 
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
