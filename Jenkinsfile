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
          withVault(configuration: [vaultUrl: 'https://dodt-vault.acldevsre.de',  vaultCredentialId: 'approle-for-vault', engineVersion: 2], vaultSecrets: [[path: 'jenkins/sonar-token', secretValues: [[envVar: 'SONAR_AUTH_TOKEN', vaultKey: 'token']]]]) {
            sh "${tool('sonar')}/bin/sonar-scanner -Dsonar.projectKey=${env.PROJECT_NAME} -Dsonar.java.binaries=target/classes -Dsonar.sources=."
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