pipeline {
  agent any
  stages {
    stage('build & SonarQube analysis') {
      agent any
      steps {
        withSonarQubeEnv('My SonarQube Server') {
          sh 'sh "/home/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonar/bin/sonar-scanner -Dsonar.host.url=https://sonar.acldevsre.de -Dsonar.projectName=java-webserver -Dsonar.projectVersion=1.0 -Dsonar.projectKey=dodt:java-webserver -Dsonar.sources=src/main/java"'
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