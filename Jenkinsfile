pipeline {
  agent {
    node {
      label 'jenkins-jenkins-slave'
    }

  }
  stages {
    stage('build & SonarQube analysis') {
      tools {
        maven 'M3'
      }
      steps {
        withSonarQubeEnv('sonar') {
          withVault(configuration: [vaultUrl: 'https://dodt-vault.acldevsre.de',  vaultCredentialId: 'approle-for-vault', engineVersion: 2], vaultSecrets: [[path: 'jenkins/sonar-token', secretValues: [[envVar: 'SONAR_AUTH_TOKEN', vaultKey: 'token']]]]) {
            sh 'mvn clean package sonar:sonar -Dsonar.projectKey=dodt:java-webserver -Dsonar.login=${env.SONAR_AUTH_TOKEN}'
          }

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

    stage('build image') {
      agent {
        kubernetes {
          yaml '''
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
    - name: docker-config
      mountPath: /kaniko/.docker/
    # when not using instance role
    - name: aws-secret
      mountPath: /root/.aws/
  volumes:
  - name: docker-config
    configMap:
      name: docker-config
  # when not using instance role
  - name: aws-secret
    secret:
      secretName: aws-secret
'''
        }

      }
      steps {
        container(name: 'kaniko') {
          unstash 'ARTIFACT'
          sh '/kaniko/executor --context `pwd` --destination 400603430485.dkr.ecr.ap-northeast-2.amazonaws.com/jenkins-java:latest'
        }

      }
    }

  }
}