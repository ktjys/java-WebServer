pipeline {
  agent {
    label 'jenkins-slave'
  }
  stages {
    stage('build') {
      tools {
        maven 'M3'
      }
      steps {
        sh 'mvn clean install -Dlicense.skip=true'
      }
    }

  }
}