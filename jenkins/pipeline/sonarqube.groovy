pipeline {
    agent any

    tools { 
      maven 'maven3.8.5'
    }

    stages {
        stage('github clone') {
            steps {
                git branch: 'main', url: 'https://github.com/scofe97/cicd-web-project'; 
            }
        }
        
        stage('build') {
            steps {
                sh '''
                    echo build start
                    mvn clean compile package -DskipTests=true
                '''
            }
        }

                stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('Sonarqube-server') {
                    sh 'mvn sonar:sonar'
                }
            }
                }
    }
} 