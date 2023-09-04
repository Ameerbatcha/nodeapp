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
                 deleteDir()
                git 'https://github.com/Ameerbatcha/nodeapp.git'
            }
        }
          stage('Build') {
            steps {
                sh 'tar czf Node.tar.gz package.json public src'
            }
        }

        stage('Docker Build'){
    steps{
        sh "echo ${DOCKER_TAG}"
        sshPublisher(publishers: [
            sshPublisherDesc(
                configName: 'docker',
                transfers: [
                    sshTransfer(
                        cleanRemote: false,
                        excludes: '',
                        execCommand: """cd /opt/docker; 
                                        tar -xf Node.tar.gz; 
                                        docker build . -t ameerbatcha/nodeapp:${DOCKER_TAG}
                                        docker push ameerbatcha/nodeapp:${DOCKER_TAG}
                                        """,
                        execTimeout: 200000,
                        flatten: false,
                        makeEmptyDirs: false,
                        noDefaultExcludes: false,
                        patternSeparator: '[, ]+$',
                        remoteDirectory: '//opt//docker',
                        remoteDirectorySDF: false,
                        removePrefix: '',
                        sourceFiles: '**/*.gz'
                    )
                ],
                usePromotionTimestamp: false,
                useWorkspaceInPromotion: false,
                verbose: true
            )
        ])
    }
}
        
         stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'dev-dockerhost', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}


def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
