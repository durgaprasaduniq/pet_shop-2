pipeline {
    agent any
      stages {
          stage("download the code") {
              steps {
                  git branch: 'main', url: 'https://github.com/durgaprasaduniq/pet_shop-2.git'
              }
          }
               stage("bulid the code") {
                  steps {
                    sh 'mvn clean package'
              }
          }      
     stage("deploy to tomcat") {
                  steps {
                    deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: '5ce1f929-5623-4138-baca-0939daa5cfb7', path: '', url: 'http://13.201.119.87:8090/')], contextPath: 'petshop', war: '**/*.war'
              }
          }      
      }
}
