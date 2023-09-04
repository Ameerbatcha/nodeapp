pipeline{
    agent any
    
    tools {
      nodejs 'node'
    }
    
    environment {
      DOCKER_TAG = getVersion()
      DOCKER_CRED= credentials('dockerhub')
    }
    
    stages{
        stage('SCM'){
            steps{
                git 'https://github.com/Ameerbatcha/nodeapp.git'
            }
        }
        
      
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'dev-dockerhost', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=latest", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
