pipeline {
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
  stages {
    stage('build & SonarQube analysis') {
      tools {
        maven 'M3'
      }
      steps {
        withSonarQubeEnv('sonar') {
          sh 'mvn clean package sonar:sonar -Dsonar.projectKey=dodt:java-webserver'
          junit 'target/surefire-reports/*.xml'
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