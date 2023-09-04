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
          stage('Build') {
            steps {
                sh 'tar czf Node.tar.gz package.json public src'
            }
        }
        
        stage('Docker Build'){
            steps{
              
                sshPublisher(publishers: [
    sshPublisherDesc(
        configName: 'docker',
        transfers: [
            sshTransfer(
                cleanRemote: false,
                excludes: '',
                execCommand: """cd /opt/docker; 
                                tar -xf Node.tar.gz; 
                                docker build . -t ameerbatcha/nodeapp:latest;
                                docker push ameerbatcha/nodeapp:latest""",
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
        
    }   
}      

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
