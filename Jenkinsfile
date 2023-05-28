pipeline {
    agent any
   
    environment {
        ANSIBLE_PRIVATE_KEY=credentials('ansible-private-key') 
        }
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
           steps{
        withDockerRegistry([ credentialsId: "docker-hub-credentials", url: "" ]) {
        sh "docker push dipinoar/nuevaimagen"
        }
           }
        }
        
        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i dev.inv --private-key=$ANSIBLE_PRIVATE_KEY ansible.yml' 
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
