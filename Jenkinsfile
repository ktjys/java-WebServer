pipeline {
  agent {
    label 'jenkins-slave'
  }
  stages {
    stage('build') {
      steps {
        sh 'mvn clean install -Dlicense.skip=true'
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
        sh '''#!/busybox/sh
echo "PATH=$PATH"
export PATH=$PATH:/kaniko
/kaniko/executor --context `pwd` --no-push'''
      }
    }

  }
  tools {
    maven 'M3'
  }
}