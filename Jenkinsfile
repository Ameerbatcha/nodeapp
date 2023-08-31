pipeline {
    agent any

    tools {
    nodejs "node"
    }
    
    stages {

        stage('Build') {
            steps {
                sh '/root/.nvm/versions/node/v12.22.1/bin/npm install'
            }
        }         

    }
}
