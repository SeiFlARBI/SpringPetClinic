pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com//SeiFlARBI/SpringPetClinic.git'
            }
        }

        stage('Build & Unit Tests') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
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
