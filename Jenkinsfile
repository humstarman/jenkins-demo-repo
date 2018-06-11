pipeline {
    agent any 
    stages {
        stage('build') {
            steps {
                sh 'kubectl create -f ./.'
            }
        }
    }
}
