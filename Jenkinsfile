pipeline {
    agent any

    environment {
        IMAGE_NAME = "frontend"
        IMAGE_TAG = "${BUILD_NUMBER}"
        ECR_REPO = "xxxxxxxx.dkr.ecr.ap-south-1.amazonaws.com/frontend"
    }

    tools {
        jdk 'jdk17'
        nodejs 'node18'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'github-ssh-key',
                url: 'git@github.com:ayareanuja0903-collab/End-to-End-Kubernetes-Three-Tier-DevSecOps-MERN-Stack-Project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                    sonar-scanner \
                    -Dsonar.projectKey=frontend \
                    -Dsonar.sources=. \
                    -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
        
        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--scan ./',
                odcInstallation: 'OWASP-DC'
            }
        }

        stage('Publish Dependency Report') {
            steps {
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        stage('Trivy File Scan') {
            steps {
                sh '''
                trivy fs . --severity HIGH,CRITICAL
                '''
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh '''
                trivy image $IMAGE_NAME:$IMAGE_TAG \
                --severity HIGH,CRITICAL \
                --exit-code 1
                '''
            }
        }

        stage('Push Image To ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ap-south-1 | \
                docker login --username AWS \
                --password-stdin xxxxxxxx.dkr.ecr.ap-south-1.amazonaws.com

                docker tag $IMAGE_NAME:$IMAGE_TAG \
                $ECR_REPO:$IMAGE_TAG

                docker push $ECR_REPO:$IMAGE_TAG
                '''
            }
        }

        stage('Update Manifest') {
            steps {
                sh '''
                sed -i "s|image:.*|image: $ECR_REPO:$IMAGE_TAG|g" \
                k8s/frontend-deployment.yaml
                '''
            }
        }

        stage('Push Manifest Changes') {
            steps {
                sh '''
                git config --global user.email "jenkins@company.com"
                git config --global user.name "jenkins"

                git add .
                git commit -m "Updated image tag ${BUILD_NUMBER}"
                git push origin main
                '''
            }
        }
    }
}