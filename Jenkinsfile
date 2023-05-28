pipeline {
    agent any
    
    tools{
        maven 'maven'
    }
    
    stages {
       
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package"
                
            }
        }
        
        stage('Docker Build') {
            steps {
                sh "docker build -t dipinoar/nuevaimagen ."
                
            }
        }
        
       stage('Push image') {
        withDockerRegistry([ credentialsId: "docker-hub-credentials", url: "" ]) {
        bat "docker push dipinoar/nuevaimagen"
        }
        }
        
        stage('Deploy Docker Container') {
            steps {
                ansiblePlaybook credentialsId: 'dev-server', installation: 'ansible2', disableHostKeyChecking: true, inventory: 'dev.inv', playbook: 'ansible.yml'
            }
        }
        
        /*
        
        stage('Clean') {
            steps {
                sh "docker image rm -f ${params.REGISTRY}/${params.SERVICE}:${params.TAG}"
                sh "docker system prune -f"
                
            }
        }
        */
    }
}
