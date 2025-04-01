pipeline{
    agent any
    tools{
        maven 'maven'
    }
    
    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/karthikramv/TestDemo.git']])
                bat 'mvn clean install'
            }
        }
        stage('Build Docker image'){
            steps{
                script{
                    bat 'docker build -t karthikvram/testdemo .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dhub-pwd', variable: 'DocHub_Pwd')]) {
                   bat 'docker login -u karthikvram -p %DocHub_Pwd%'   
}
                   bat 'docker push karthikvram/testdemo'
                }
            }
        }
    }
}