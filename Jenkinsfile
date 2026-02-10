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
      }
}
