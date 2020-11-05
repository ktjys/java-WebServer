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
      }
      steps {
        withSonarQubeEnv('sonar') {
          script {
            def scannerHome=tool 'sonar'
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${env.PROJECT_NAME} -Dsonar.java.binaries=target/classes -Dsonar.sources=. -Dsonar.login=ed4d9996ab4948f15e756be7ab126bae0d6fe881"
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