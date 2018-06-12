pipeline {
    agent any 
    parameters {
        string(name: 'project', defaultValue: 'test-demo', description: 'the name of the project')
        string(name: 'tag', defaultValue: 'v1', description: 'the tag of the docker image')
        string(name: 'local_registry', defaultValue: '172.31.78.217:5000', description: 'local docker registry')
        string(name: 'namespace', defaultValue: 'default', description: 'the namespace of the project')
        string(name: 'n', defaultValue: '1', description: 'the number to echo')
    }
    environment {
        PROJECT = "${params.project}"
        TAG = "${params.tag}"
        LOCAL_REGISTRY = "${params.local_registry}"
        NAMESPACE = "${params.namespace}"
        NUM = "${params.n}"
    }
    stages {
        stage('Build') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {   
                    retry(5) {
                        sh "docker build -t ${params.local_registry}/${params.project}:${params.tag} ."
                    }
                }
                sh "docker push ${params.local_registry}/${params.project}:${params.tag}"
            }
        }
        stage('Deploy - Staging') {
            steps {
                sh "sed -i s/\"{{.namespace}}\"/\"${params.namespace}\"/g ./manifest/controller.yaml"
                sh "sed -i s/\"{{.project}}\"/\"${params.project}\"/g ./manifest/controller.yaml"
                sh "sed -i s/\"{{.local.registry}}\"/\"${params.local_registry}\"/g ./manifest/controller.yaml"
                sh "sed -i s/\"{{.tag}}\"/\"${params.tag}\"/g ./manifest/controller.yaml"
                sh "sed -i s/\"{{.num}}\"/\"${params.n}\"/g ./manifest/controller.yaml"
                sh "if kubectl -n ${params.namespace} get pod | grep ${params.project}; then kubectl delete -f ./manifest/controller.yaml; fi"
            }
        }
        stage('Sanity check') {
            steps {
                input "Does the staging environment look ok?"
            }
        }
        stage('Deploy - Production') {
            steps {
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
