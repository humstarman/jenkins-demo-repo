pipeline {
    agent any 
    stages {
        stage('build') {
            steps {
                sh 'docker build -t 172.31.78.217:5000/test-demo:v2 .'
                sh 'docker push 172.31.78.217:5000/test-demo:v2'
            }
        }
        stage('deploy') {
            steps {
                sh 'if kubectl -n defaul tget pod | grep test-demo; then kubectl delete -f ./manifest/controller.yaml; fi'
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
}
