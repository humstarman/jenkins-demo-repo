pipeline {
    agent any 
    environment {
        PROJECT = "test-demo"
        TAG = "v3"
        LOCAL_REGISTRY = "172.31.78.217:5000"
        NAMESPACE= "default"
    }
    stages {
        stage('build') {
            steps {
                sh 'docker build -t ${LOCAL_REGISTRY}/${PROJECT}:${TAG} .'
                sh 'docker push -t ${LOCAL_REGISTRY}/${PROJECT}:${TAG}'
            }
        }
        stage('deploy') {
            steps {
                sh 'if kubectl -n $NAMESPACE get pod | grep ${PROJECT}; then kubectl delete -f ./manifest/controller.yaml; fi'
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
}
