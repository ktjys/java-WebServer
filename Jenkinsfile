pipeline {
  agent {
    label 'jenkins-slave'
  }
  stages {
    stage('build') {
      tools {
        maven 'M3'
      }
      steps {
        sh 'mvn clean install -Dlicense.skip=true'
        stash 'ARTIFACT'
      }
    }

    stage('build image') {
      agent {
        kubernetes {
          label 'kaniko-test'
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
        container(name: 'kaniko', shell: '/busybox/sh') {
          unstash 'ARTIFACT'
          sh '/kaniko/executor --context `pwd` --destination 400603430485.dkr.ecr.ap-northeast-2.amazonaws.com/jenkins-java:latest'
        }

      }
    }

  }
}