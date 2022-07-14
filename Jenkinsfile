pipeline {
agent any
   tools {
       maven 'M2'
   }
    stages {
        stage ('Build') {
            steps {
                git 'https://github.com/Shi191099/Dockerize-Java-app.git'
                sh 'mvn clean package'
            }
            
        }
        stage ('deploy') {
            steps {
                deploy adapters: [
                    tomcat9
                    (
                        credentialsId: '5d352b89-ab10-4b92-922a-f2ef77e7f5dd', 
                        path: '', 
                        url: 'http://3.109.143.45:8090'
                    )
                ], 
                contextPath: 'web', 
                war: '**/*.war'
            }
        }
        stage ('build Docker img') {
            steps {
                sh 'docker build -t dockerize-java-app .'
            }
        }
        stage ('push Docker img') {
            steps {
                withCredentials([string(credentialsId: 'docker-s3cret', variable: 'docker')]) {
                    sh 'docker login -u shikashi -p ${docker}'
                }
                
                sh 'docker push dockerize-java-app'
            }
        }
        stage ('Run Container on Dev Server') {
            steps {
                //variable dockerRun = 'docker run -d --name webapp -p 80:8080 shikashi/war'
                sshagent(['pem']) {
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.47.18'
                    sh 'docker run -d -P dockerize-java-app'
                }
            }
        }
    }
}
