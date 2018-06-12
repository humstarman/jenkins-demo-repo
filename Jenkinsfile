pipeline {
    agent any 
    parameters {
        string(name: 'PROJECT', defaultValue: 'test-demo', description: 'the name of the project')
        string(name: 'TAG', defaultValue: 'v3', description: 'the tag of the docker image')
        string(name: 'LOCAL_REGISTRY', defaultValue: '172.31.78.217:5000', description: 'local docker registry')
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'the namespace of the project')
    }
    stages {
        stage('build') {
            timeout(time: 3, unit: 'MINUTES') {   
                retry(5) {
                    steps {
                        sh "docker build -t ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG} ."
                        sh "docker push ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG}"
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                sh "sed -i s/{{.namespace}}/${params.NAMESPACE}/g ./manifest/controller.yaml"
                sh "sed -i s/{{.project}}/${params.PROJECT}/g ./manifest/controller.yaml"
                sh "sed -i s/{{.local.registry}}/${params.LOCAL_REGISTRY}/g ./manifest/controller.yaml"
                sh "sed -i s/{{.tag}}/${params.TAG}/g ./manifest/controller.yaml"
                sh "if kubectl -n ${params.NAMESPACE} get pod | grep ${params.PROJECT}; then kubectl delete -f ./manifest/controller.yaml; fi"
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
}
