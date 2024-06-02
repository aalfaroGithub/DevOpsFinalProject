pipeline {
    agent any

    environment {
        dockerimagename = "andresdckr/devopsfinalproject-todo"
        dockerImage = ''
        registryCredential = 'dockerhub'
    }

    stages {
        // Checkin the git repository
        // stage ('Checkout source code') {
        //     steps {
        //         git 'https://github.com/aalfaroGithub/DevOpsFinalProject.git'
        //     }
        // }
        // Checkout docker info to see if it's running
        /*stage ('Docker Info') {
            steps {
                sh 'docker info'
            }
        }
        stage ('Docker image') {
            steps {
                script {
                    dockerImage = docker.build dockerimagename
                }
            }
        }
        stage ('Docker push') {
            environment {
                registryCredential = 'dockerhublogin'
            }
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push("2.0")
                    }
                }
            }
        }*/
        /*stage ('Sonarqube') {
            steps {
                script {
                    docker.image('sonarsource/sonar-scanner-cli:latest').inside {
                        sh '''
                            sonar-scanner \
                                -Dsonar.host.url=http://172.17.0.2:9000 \
                                -Dsonar.projectKey=devopsfinalproject-todo \
                                -Dsonar.sources=src \
                                -Dsonar.token=squ_7e0170b3fd4ed9234db70199102b5f4c0d1ec6b3
                        '''
                    }
                }
            }
        }*/
        // Stage to run the terraform script to create the Ec2 instance
        stage ('Run Terraform Init') {
            steps {
                dir('./deploy/terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage ('Run Terraform Plan') {
            steps {
                dir('./deploy/terraform') {
                    sh 'terraform plan'
                }
            }
        }
        stage ('Run Terraform Apply') {
            steps {
                dir('./deploy/terraform') {
                    sh 'terraform apply -auto-approve'
                    script {
                        env.TF_OUTPUT_IP = sh(script: 'terraform output ec2_instance_ip', returnStdout: true).trim()
                    }
                }
            }
        }
        // Running the ansible playbook to install the necessary software using the ip address of the ec2 instance
        stage ('Run Ansible Playbook') {
            steps {
                dir('./deploy/Ansible') {
                    sh 'chmod 600 ~/Documents/ansible/key_pair.pem'
                    sh "ansible-playbook -i ${TF_OUTPUT_IP}, --private-key=~/Documents/ansible/key_pair.pem --user=ubuntu ec2.yaml --ssh-common-args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'"
                }
            }
        }
        /*stage ('Apply SqlConfigMap ') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'mykubeconfig']) {
                        sh 'kubectl apply -f deploy/kubernetes/mysql-config.yaml'
                    }
                    // kubernetesDeploy(configs: 'deploy/kubernetes/mysql-config.yaml', kubeconfigId: 'mykubecred', namespace: 'default')
                }
            }
        }
        stage ('Apply MySqlDeployment') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'mykubeconfig']) {
                        sh 'kubectl apply -f deploy/kubernetes/mysql.yaml'
                    }
                    // kubernetesDeploy(configs: 'deploy/kubernetes/mysql.yaml', kubeconfigId: 'mykubecred', namespace: 'default')
                }
            }
        }
        stage ('Apply Deployment') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'mykubeconfig']) {
                        sh 'kubectl apply -f deploy/kubernetes/deploy.yaml'
                    }
                    // kubernetesDeploy(configs: 'deploy/kubernetes/deploy.yaml', kubeconfigId: 'mykubecred', namespace: 'default')
                }
            }
        }
        stage ('Apply Ingress') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'mykubeconfig']) {
                        sh 'kubectl apply -f deploy/kubernetes/ingress.yaml'
                    }
                    // kubernetesDeploy(configs: 'deploy/kubernetes/ingress.yaml', kubeconfigId: 'mykubecred', namespace: 'default')
                }
            }
        }*/
    }
    post {
        failure {
            dir('./deploy/terraform') {
                echo 'Cleaning up'
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}