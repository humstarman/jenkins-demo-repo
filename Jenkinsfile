pipeline {
    agent any 
    stages {
        stage('build') {
            steps {
                sh 'docker build -t 172.31.78.217:5000/test-demo:v1 .'
                sh 'docker push 172.31.78.217:5000/test-demo:v1'
            }
        }
        stage('deploy') {
            steps {
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
}
