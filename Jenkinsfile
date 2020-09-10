pipeline {
  agent {
    kubernetes k8sagent(name: 'jenkins-slave')
  }
  stages {
    stage('build') {
      steps {
        sh 'mvn clean install -Dlicense.skip=true'
      }
    }

  }
  tools {
    maven 'M3'
  }
}