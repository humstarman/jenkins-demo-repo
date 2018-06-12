pipeline {
    agent any 
    environment {
        PROJECT = "test-demo"
        TAG = "v3"
        LOCAL_REGISTRY = "172.31.78.217:5000"
        NAMESPACE= "default"
    }
    parameters {
        string(name: 'PROJECT', defaultValue: 'test-demo', description: 'the name of the project')
        string(name: 'TAG', defaultValue: 'v3', description: 'the tag of the docker image')
        string(name: 'LOCAL_REGISTRY', defaultValue: '172.31.78.217:5000', description: 'local docker registry')
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'the namespace of the project')
    }
    stages {
        stage('build') {
            steps {
                sh "docker build -t ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG} ."
                sh "docker push ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG}"
            }
        }
        stage('deploy') {
            steps {
                sh 'if kubectl -n ${params.NAMESPACE} get pod | grep ${params.PROJECT}; then kubectl delete -f ./manifest/controller.yaml; fi'
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
}
