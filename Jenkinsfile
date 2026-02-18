pipeline {
    agent any

    environment {
        IMAGE_NAME = "nthomas13/nodejs-devops-project3"
        TAG = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/nthomas013/NodeJS-devops-project3.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t nthomas13/nodejs-devops-project3 .
                '''
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'DOCKER_HUB_CRED',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                      docker push $IMAGE_NAME:$TAG
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                  kubectl apply -f k8s/deployment.yml
                  kubectl apply -f k8s/service.yml
                  kubectl rollout status deployment/nodejs-app
                '''
            }
        }
    }
}

