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
                      sh 'cp /var/lib/jenkins/workspace/jenkins/target/*.war /home/ec2-user/tomcat/webapps/'
              }
          }      
      }
}
