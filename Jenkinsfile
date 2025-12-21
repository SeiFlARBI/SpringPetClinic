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
                    sh 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('UI Tests - Selenium') {
            steps {
                sh 'mvn test -DsuiteXmlFile=testng.xml'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t mon-app:latest .'
            }
        }
    }
}
