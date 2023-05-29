pipeline {
    agent any

    stages {
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ttl.sh/pythonapp-brayand:1h ."
            }
        }

        stage('Push Docker Image') {
            steps {
               sh "docker push ttl.sh/pythonapp-brayand:1h"
            }
        }

        stage('Pull Docker Image') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-ssh-credentials', keyFileVariable: 'KeyFile', usernameVariable: 'userName')]) {
                    sh "ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts"

                    sh "ssh -l ${userName} -i ${KeyFile} 192.168.105.3 -C docker pull ttl.sh/pythonapp-brayand:1h"
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-ssh-credentials', keyFileVariable: 'KeyFile', usernameVariable: 'userName')]) {
                    sh "ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts"

                    sh "ssh -l ${userName} -i ${KeyFile} 192.168.105.3 -C docker run -d -p 4444:4444 ttl.sh/pythonapp-brayand:1h"
                }
            }
        }

        stage('Health Check') {
            steps {
                sh "curl -s http://192.168.105.3:4444/api"
            }
        }
    }
}
