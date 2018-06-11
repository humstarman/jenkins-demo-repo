pipeline {
    agent any 
    stages {
        stage('build') {
            steps {
                kubectl create -f ./. 
            }
        }
    }
}
