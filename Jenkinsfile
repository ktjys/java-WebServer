pipeline {
  agent {
    label 'jenkins-slave'
  }
  stages {
    stage('build & SonarQube analysis') {
      tools {
        maven 'M3'
      }
      steps {
        withSonarQubeEnv('sonar') {
          sh 'mvn clean package sonar:sonar -Dsonar.projectKey=dodt:java-webserver'
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