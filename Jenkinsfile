pipeline {
  agent any
  stages {
    stage('preparation') {
      steps {
        git(url: 'https://github.com/ktjys/java-WebServer.git', branch: 'master', changelog: true)
      }
    }

  }
}