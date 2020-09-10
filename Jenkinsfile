pipeline {
  agent any
  stages {
    stage('preparation') {
      steps {
        git(url: 'https://github.com/ktjys/java-WebServer.git', branch: 'master', changelog: true)
        sh '''echo "PATH = ${PATH}"
echo "M2_HOME = ${M2_HOME}"'''
      }
    }

    stage('build') {
      steps {
        tool 'M3'
        sh 'mvn -Dmaven.test.failure.ignore clean package'
      }
    }

  }
}