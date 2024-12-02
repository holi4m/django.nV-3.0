pipeline {
    agent any
        environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '172.31.37.40'
        DEPLOY_PATH = '/home/ubuntu/djangonV'
    
        }
    stages {
        stage('Deploy to Server') {
            steps {
                sshagent (credentials:['KEY_holiam_ec2_pem']){
                sh '''
                ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} "
                    /home/ubuntu/djangonV/cicd
                "
                '''
            }
        }
    }
}
}