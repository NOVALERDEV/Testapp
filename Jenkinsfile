pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    bat 'docker build -t python-app .'
                    // Si tu es sous Linux / macOS, remplace bat par sh :
                    // sh 'docker build -t python-app .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Lancer un conteneur à partir de l'image
                    bat 'docker run --rm python-app'
                    // sh 'docker run --rm python-app' sur Linux / macOS
                }
            }
        }
    }
}
