pipeline {
    agent any

    environment {
        IMAGE_NAME = 'employee-app'
        CONTAINER_NAME = 'employee-app-container'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'Github',
                    url: 'git@github.com:GiribabuGBB/Application-1.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh '/opt/maven/bin/mvn clean package'
            }
        }

        stage('Check Artifact') {
            steps {
                sh 'pwd'
                sh 'ls -la'
                sh 'ls -la target'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Remove Existing Container') {
            steps {
                sh 'docker rm -f ${CONTAINER_NAME} || true'
            }
        }

        stage('Docker Run Container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}:latest'
            }
        }

        stage('Verify Docker Container') {
            steps {
                sh 'docker ps'
                sh 'docker ps -a'
            }
        }
    }

    post {
        success {
            echo 'Application Deployed'
        }
        failure {
            echo 'Deployment Failed'
        }
    }
}
