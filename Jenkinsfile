pipeline {
  agent any
  stages {
    stage('preparation') {
      steps {
        git(url: 'https://github.com/ktjys/java-WebServer.git', branch: 'master', changelog: true)
      }
    }

    stage('build') {
      steps {
        sh 'mvn -Dmaven.test.failure.ignore clean package'
      }
    }

  }
}