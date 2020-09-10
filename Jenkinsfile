pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        tool(name: 'maven', type: 'maven')
        script {
          def mvnHome = tool name: 'M3', type: 'maven'
        }

        sh '${mvnHome}/bin/mvn clean install -Dlicense.skip=true'
      }
    }

  }
}