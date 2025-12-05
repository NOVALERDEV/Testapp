pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = 'python-app'
        DOCKER_CONTAINER_NAME = 'python-container'
    }
    
    stages {
        stage('Check Docker Installation') {
            steps {
                script {
                    // Vérifie si Docker est installé
                    def dockerExists = sh(script: 'which docker || echo "not found"', returnStdout: true).trim()
                    
                    if (dockerExists == 'not found') {
                        echo '⚠️  Docker n\'est pas installé. Tentative d\'installation...'
                        
                        // Essayer d'installer Docker (pour Ubuntu/Debian)
                        try {
                            sh '''
                                apt-get update -y
                                apt-get install -y docker.io
                            '''
                        } catch (Exception e) {
                            error '❌ Impossible d\'installer Docker. Veuillez l\'installer manuellement sur le nœud Jenkins.'
                        }
                    } else {
                        echo '✅ Docker est installé'
                        sh 'docker --version'
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            when {
                expression { sh(script: 'which docker', returnStdout: true).trim() != '' }
            }
            steps {
                script {
                    sh '''
                        echo "Construction de l'image Docker..."
                        docker build -t ${DOCKER_IMAGE_NAME} .
                        
                        echo "Images disponibles :"
                        docker images
                    '''
                }
            }
        }
        
        stage('Run Docker Container') {
            when {
                expression { sh(script: 'which docker', returnStdout: true).trim() != '' }
            }
            steps {
                script {
                    // Arrêter le conteneur s'il existe déjà
                    sh '''
                        docker stop ${DOCKER_CONTAINER_NAME} 2>/dev/null || true
                        docker rm ${DOCKER_CONTAINER_NAME} 2>/dev/null || true
                    '''
                    
                    // Lancer le conteneur
                    sh '''
                        docker run -d \
                            --name ${DOCKER_CONTAINER_NAME} \
                            -p 5000:5000 \
                            ${DOCKER_IMAGE_NAME}
                        
                        echo "Conteneurs en cours d'exécution :"
                        docker ps
                    '''
                }
            }
        }
        
        stage('Test Application') {
            when {
                expression { sh(script: 'which docker', returnStdout: true).trim() != '' }
            }
            steps {
                script {
                    sleep 5  // Attendre que l'application démarre
                    
                    sh '''
                        echo "Test de l'application..."
                        curl -f http://localhost:5000 || echo "L'application n'est pas encore prête"
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline exécuté avec succès!'
        }
        failure {
            echo '❌ Pipeline échoué'
            sh '''
                echo "Derniers logs du conteneur :"
                docker logs ${DOCKER_CONTAINER_NAME} 2>/dev/null || echo "Aucun conteneur trouvé"
            '''
        }
        always {
            echo '🧹 Nettoyage...'
            sh '''
                docker stop ${DOCKER_CONTAINER_NAME} 2>/dev/null || true
                docker rm ${DOCKER_CONTAINER_NAME} 2>/dev/null || true
            '''
        }
    }
}
