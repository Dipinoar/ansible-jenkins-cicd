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
           steps{
        withDockerRegistry([ credentialsId: "docker-hub-credentials", url: "" ]) {
        sh "docker push dipinoar/nuevaimagen"
        }
           }
        }
        
        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Instalar el plugin Pipeline Utility Steps
                    // Utilizar el paso 'withCredentials' para ocultar la contraseña
                    withCredentials([usernamePassword(credentialsId: 'dev-server', passwordVariable: 'ANSIBLE_PASS', usernameVariable: 'ANSIBLE_USER')]) {
                        ansiblePlaybook(
                            playbook: 'ansible.yml',
                            inventory: 'dev.inv',
                            extras: '--ask-become-pass',
                            sudoUser: env.ANSIBLE_USER,
                            sudoPass: env.ANSIBLE_PASS
                        )
                    }
                }
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
