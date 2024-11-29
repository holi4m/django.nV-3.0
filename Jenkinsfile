pipeline {
    agent any
    environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '172.31.37.40'
        DEPLOY_PATH = '/home/ubuntu/djangonV'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/holi4m/django.nV-3.0.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh '''
                ssh ${DEPLOY_USER}@${DEPLOY_HOST} "
                    cd ${DEPLOY_PATH} &&
                    python3 -m venv venv &&
                    source venv/bin/activate &&
                    pip install -r requirements.txt
                "
                '''
            }
        }
        stage('Run Tests') {
            steps {
                sh '''
                ssh ${DEPLOY_USER}@${DEPLOY_HOST} "
                    cd ${DEPLOY_PATH} &&
                    source venv/bin/activate &&
                    python manage.py test
                "
                '''
            }
        }
        stage('Start Django Server') {
            steps {
                sh '''
                ssh ${DEPLOY_USER}@${DEPLOY_HOST} "
                    cd ${DEPLOY_PATH} &&
                    source venv/bin/activate &&
                    nohup python manage.py runserver 0.0.0.0:8000 &
                "
                '''
            }
        }
    }
    post {
        always {
            echo "Pipeline completed."
        }
    }
}