pipeline {
    agent any

    environment {
        IMAGE_NAME = "joke"
        DOCKER_USER = "vikicr7"
    }

    stages {
        stage('Checkouti') {
            steps {
                git 'https://github.com/vikicr7/njsprojectmine.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Trivy Scannsi:') {
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
                    sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null deploy.sh vikicr7@3.109.186.0:/home/ubuntu/'
                    sh 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null vikicr7@3.109.186.0 "chmod +x deploy.sh && ./deploy.sh"'
                }
            }
        }
    }
}
