pipeline {
    //agent any
agent {
   docker { image 'python:3.9-slim' }
} 
stage('Build Docker Image') {  
       // stage('Run Docker Container') {
    steps {
        script {
                    // Lancer un conteneur à partir de l'image
                    //bat 'docker run --rm python-app'
                sh 'docker run --rm python-app' //sur Linux / macOS
        }
    }
}
}
