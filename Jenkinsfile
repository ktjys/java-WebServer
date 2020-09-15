pipeline {
  agent any
  stages {
    stage('build & SonarQube analysis') {
      agent any
      steps {
        withSonarQubeEnv('SONARQUBE') {
          withMaven(maven: 'Maven 3.5') {
            sh 'mvn clean package sonar:sonar'
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