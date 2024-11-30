pipeline {
    agent any

    stages {

        stage('github-clone') {
            steps {
                git branch: 'main', credentialsId: 'GITHUB_TOKEN', url: 'https://github.com/SeonRilla97/cicd.git'
            }

            stage('build'){
                steps{
                        sh '''
                            echo build start
                        '''
                }
            }
        }

   		// stage...
   	}
}