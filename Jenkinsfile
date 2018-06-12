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
            steps {
                timeout(time: 3, unit: 'MINUTES') {   
                    retry(5) {
                        sh "docker build -t ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG} ."
                    }
                }
                sh "docker push ${params.LOCAL_REGISTRY}/${params.PROJECT}:${params.TAG}"
            }
        }
        stage('deploy') {
            steps {
                sh './ch-templ.sh'
                sh "if kubectl -n ${params.NAMESPACE} get pod | grep ${params.PROJECT}; then kubectl delete -f ./manifest/controller.yaml; fi"
                sh 'kubectl create -f ./manifest/controller.yaml'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
