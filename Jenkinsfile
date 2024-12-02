pipeline {
    agent any
    stages {
        stage('Deploy to Server') {
            steps {
                sshagent (credentials:['KEY_holiam_ec2_pem']){
                sh '''
                ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} "
                    /home/ubuntu/djangonV/cicd.sh
                "
                '''
            }
        }
    }
}
}
