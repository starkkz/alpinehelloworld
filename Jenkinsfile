pipeline {
  agent any
  stages {
    stage('Build Docker') {
      steps {
        sh 'docker build -t myregistry/myapp:${BUILD_NUMBER} .'
        sh 'docker push myregistry/myapp:${BUILD_NUMBER}'
      }
    }
    stage('Deploy to K8s') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
    stage('Test') {
      steps {
        sh 'kubectl get pods'
        sh 'curl http://<NodeIP>:<NodePort>'
      }
    }
  }
}
