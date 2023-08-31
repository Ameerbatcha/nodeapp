pipeline{
    agent any
  
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        
        stage('SCM'){
            steps{
                git 'https://github.com/Ameerbatcha/nodeapp.git'
            }
        }
        
        stage('packing') {
            steps {
               sh 'tar czf Node.tar.gz package.json public src'
            }
        }
        
        stage('Build'){
            steps{
               
                sh "docker build . -t ameerbatcha/nodeapp:${DOCKER_TAG}"
            }
        }
        
        stage('DockerHub Push'){
            steps{
                 withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhubpasswd')]) {
                      sh 'docker login -u ameerbatcha -p ${dockerhubpasswd}'
                   }
             
              sh 'docker push ameerbatcha/nodeapp:${DOCKER_TAG}'
            }
        }
        
        stage('Docker Deploy'){
            steps{
             ansiblePlaybook credentialsId: 'dev-dockerhost', disableHostKeyChecking: true, extras: '-e DOCKER_TAG=${DOCKER_TAG}', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
