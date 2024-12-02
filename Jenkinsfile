pipeline {
    agent any
    environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '172.31.37.40'
        DEPLOY_PATH = '/home/ubuntu/djangonV'
        PEM_KEY = '~/.ssh/Key_Holiam_EC2_Pem.pem' // PEM 키 파일 경로
    }
    stages {
        stage('Deploy to Server') {
            steps {
                sshagent (credentials:['KEY_holiam_ec2_pem']){
                sh '''
                ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} "
                    mkdir -p ${DEPLOY_PATH} &&
                    cd ${DEPLOY_PATH} &&
                    git pull &&
                    python3 -m venv venv &&
                    source venv/bin/activate &&
                    pip install -r requirements.txt &&
                    python manage.py migrate &&
                    nohup runapp.sh &
                "
                '''}
            }
        }
    }
}
