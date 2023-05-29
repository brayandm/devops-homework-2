pipeline {
    agent any

    stages {
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t pythonapp-BrayanD ."
            }
        }

        stage('Push Docker Image') {
            steps {
               sh "docker push ttl.sh/pythonapp-BrayanD:latest"
            }
        }

        stage('Pull Docker Image') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-ssh-credentials', keyFileVariable: 'KeyFile', usernameVariable: 'userName')]) {
                    sh "ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts"

                    sh "ssh -l ${userName} -i ${KeyFile} 192.168.105.3 -C docker pull ttl.sh/pythonapp-BrayanD:latest"
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-ssh-credentials', keyFileVariable: 'KeyFile', usernameVariable: 'userName')]) {
                    sh "ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts"

                    sh "ssh -l ${userName} -i ${KeyFile} 192.168.105.3 -C docker run -d -p 4444:4444 ttl.sh/pythonapp-BrayanD:latest"
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
