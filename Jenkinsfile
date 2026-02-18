pipeline {
    agent any

    environment {
        IMAGE_NAME = "nthomas13/simplenodejsapplication"
        TAG = "latest"
    }

    stages {

        stage('Checkout code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/nthomas013/simplenodejsapplication.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t nthomas13/simplenodejsapplication .
                '''
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'DOCKER_HUB_CREDS',
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

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                  kubectl apply -f kubernetes/deployment.yml
                  kubectl apply -f kubernetes/service.yml
                  kubectl rollout status deployment/nodejs-app
                '''
            }
        }
    }
}

