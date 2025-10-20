pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-extended-demo"
        DOCKER_USER = "vikicr7"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/devops-extended-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'chmod +x trivy-scan.sh && ./trivy-scan.sh'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER_C', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER_C --password-stdin
                        docker tag $IMAGE_NAME:latest $DOCKER_USER_C/$IMAGE_NAME:latest
                        docker push $DOCKER_USER_C/$IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                // requires Jenkins credentials: ec2-ssh-key (SSH private key) and configured ssh-agent plugin
                sshagent(['ec2-ssh-key']) {
                    sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null deploy.sh vikicr7@<EC2-IP>:/home/ubuntu/'
                    sh 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null vikicr7@<EC2-IP> "chmod +x deploy.sh && ./deploy.sh"'
                }
            }
        }
    }
}
