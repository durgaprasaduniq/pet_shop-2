pipeline {
    agent { label "label"
}
    environment {
        IMAGE_NAME= "durgaprasaduniq/gc"
        TAG= "mine"
        DOCKER_USER= "durgaprasaduniq"
        DOCKER_PASSWD= ""
        CLUSTER_NAME= "my-cluster"
        AWS_REGION= "us-east-1"
    }
       stages{
           stage("git checkout"){
               steps {
                   git 'https://github.com/durgaprasaduniq/nodejs-app-mss.git'
               }
           }
           stage("build docker ") {
               steps{
                   sh 'docker build -t $IMAGE_NAME:$TAG -f Dockerfile .'
                  }
              }  
              stage("trivy scan"){
                  steps{
                      sh 'trivy image --severity HIGH,CRITICAL --exit-code 0 $IMAGE_NAME:$TAG'
                  }
              }
              
               stage("docker login"){
                   steps {
                        withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                      }
                   }
               }
                      stage("docker push"){
                          steps {
                              sh 'docker push $IMAGE_NAME:$TAG'
                          }
                      }
                      stage("connect to eks"){
                          steps {
                              sh 'aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION'
                          }
                      }
                    stage("deploy to server"){
                        steps{
                            sh '''
                             kubectl apply -f deployment.yml
                             kubectl apply -f service.yml
                             '''
                        }
                    }
       }
}
