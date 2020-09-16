pipeline {
  agent any
  stages {
    stage('build & SonarQube analysis') {
      tools {
        maven 'M3'
      }
      steps {
        withSonarQubeEnv('sonar') {
          sh 'mvn clean package sonar:sonar -Dsonar.projectKey=dodt:java-webserver'
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
          label 'kaniko'
          yaml '''
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    imagePullPolicy: Always
    command:
    - cat
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
        container(name: 'kaniko', shell: '/busybox/sh') {
          unstash 'ARTIFACT'
          sh '/kaniko/executor --context `pwd` --destination 400603430485.dkr.ecr.ap-northeast-2.amazonaws.com/jenkins-java:latest'
        }

      }
    }

  }
  post {
    always {
      junit '**/reports/junit/*.xml'
    }

  }
}