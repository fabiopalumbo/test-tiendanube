pipeline {
    agent none

    stages {
        stage ('Checkout') {
            agent {
                label 'master'
            }
            steps {
                checkout scm
            }
        }    

        stage ('Terraform Init & Plan') {
            agent {
                label 'master'
            }
            steps {
                  sh '''
                     cd terraform
                     terraform init
                     terraform plan
                  '''
                }
                                
            }
        }

        stage ('Terratest') {
            agent {
                label 'master'
            }
            steps {

                echo "Testing Orchestation with Terratest"
                sh '''
                  cd terraform/test
                  go mod init test.com/v1
                  go mod download                
                  go test -v
                '''
                
            }
        }

        stage ('Deploy terraform') {
            agent {
                label 'master'
            }
            steps {
                sh '''
                  cd terraform
                  terraform apply -auto-approve
                '''
            }
        }
        stage ('Smoke Test') {
            agent {
                label 'master'
            }
            steps {
                sleep 60
                echo "Smoke Test"
            }
        }        

    }

    post {
        always {
            cleanWs()
            echo "Build finish"
        }
    }
}
