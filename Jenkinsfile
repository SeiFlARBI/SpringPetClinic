pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        SONAR_TOKEN = credentials('sonar-token') // ID of your Jenkins credential
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com//SeiFlARBI/SpringPetClinic.git'
            }
        }

        stage('Build & Unit Tests') {
            steps {
                sh 'mvn -version'
                sh 'mvn clean'
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN"
                }
            }
        }

        stage('UI Tests - Selenium') {
            steps {
                sh 'mvn test -DsuiteXmlFile=testng.xml'
            }
        }

        stage('Build & Push Docker') {
            steps {
                // Login Docker Hub
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', 
                                          usernameVariable: 'DOCKER_USER', 
                                          passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }

                // Build et push l'image
                sh 'docker build -t sssff/springpetclinic:latest .'
                sh 'docker push sssff/springpetclinic:latest'
            }
        }
    }
}
