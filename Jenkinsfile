pipeline {
    agent any
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Namrata1-99/CICD-demo']]])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t namrata99/cicd-demo:${BUILD_NUMBER}  .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'DOCKER_SECRET', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u namrata99 -p ${dockerhubpwd}'

}
                   sh 'docker push namrata99/cicd-demo:${BUILD_NUMBER}'
                }
            }
        }
        stage('Scan the image'){
             steps{
                 script{
                    sh 'trivy image namrata99/cicd-demo:${BUILD_NUMBER} > scanning.txt '
                 }
             }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
        stage('SonarQube analysis') {
            steps{
                script{
                    def scannerHome = tool 'sonarqube';
                    withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner \
                    -D sonar.login=admin \
                    -D sonar.password=YQS9QQjTe!i5rE8 \
                    -D sonar.projectKey=sonarqubetest \
                    -D sonar.exclusions=vendor/**,resources/**,**/*.java \
                    -D sonar.host.url=http://localhost:9000/"
                    }
                    }
                }
       }
    }
}
