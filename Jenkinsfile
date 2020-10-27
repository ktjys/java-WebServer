pipeline {
  agent any
  stages {
    stage('SonarQube analysis') {
      environment {
        SCANNER_HOME = 'SonarQubeScanner'
        ORGANIZATION = 'dodt'
        PROJECT_NAME = 'java-webserver-test'
        SONAR_AUTH_TOKEN = 'd9cb2418cd8bf7c41cf608d82796004a840e5ac0'
      }
      steps {
        script {
          def scannerHome=tool 'sonarscanner'

          sh "echo ${scannerHome}"
          withSonarQubeEnv('sonar') {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.organization=$ORGANIZATION -Dsonar.java.binaries=build/classes/java/ -Dsonar.projectKey=$PROJECT_NAME -Dsonar.sources=. -Dsonar.login=$SONAR_AUTH_TOKEN"
          }
        }

      }
    }

    stage('Quality Gate') {
      steps {
        timeout(time: 1, unit: 'HOURS') {
          waitForQualityGate true
        }

      }
    }

  }
}