pipeline {
  agent any
  stages {
    stage('Build') {
      tools {
        maven 'M3'
      }
      steps {
        sh 'mvn clean package'
      }
    }

    stage('SonarQube analysis') {
      environment {
        SCANNER_HOME = 'SonarQubeScanner'
        PROJECT_NAME = 'dodt:java-webserver-test'
        SONAR_AUTH_TOKEN = 'd9cb2418cd8bf7c41cf608d82796004a840e5ac0'
      }
      steps {
        script {
          def scannerHome=tool 'sonar'

          sh "echo ${scannerHome}"
          withSonarQubeEnv('sonar') {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${env.PROJECT_NAME} -Dsonar.java.binaries=target/classes -Dsonar.sources=. "
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