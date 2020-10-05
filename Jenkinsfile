pipeline {
  agent none
  stages {
    stage('build & SonarQube analysis') {
      tools {
        maven 'M3'
      }
      steps {
        withSonarQubeEnv('sonar') {
          sh 'mvn clean package sonar:sonar -Dsonar.projectKey=dodt:java-webserver'
          junit 'target/surefire-reports/*.xml'
          stash 'ARTIFACT'
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