pipeline {
  agent any
  stages {
    stage('build') {
      agent {
        label 'jenkins-slave'
      }
      steps {
        sh 'mvn clean install -Dlicense.skip=true'
      }
    }

  }
  tools {
    maven 'M3'
  }
}