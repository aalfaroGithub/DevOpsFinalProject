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
        // Clone the repository if it's not already cloned
        // Checkout docker info to see if it's running
        stage ('Docker Info') {
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
        }
        stage ('Apply kubeconfig') {
            steps {
                script {
                    kubernetesDeploy(configs: 'deploy/kubernetes/mysql-config.yaml', kubeconfigId: 'mykubecred', enableConfigSubstitution: true, enableSubstitution: true, showLogs: true, verbose: true, wait: true, namespace: 'default')
                }
            }
        }
        // stage ('Apply MySqlDeployment') {
        //     steps {
        //         sh "kubectl apply -f deploy/kubernetes/mysql-config.yaml"
        //         sh "kubectl apply -f deploy/kubernetes/mysql.yaml"
        //     }
        // }
        // stage ('Apply Deployment') {
        //     steps {
        //         sh "kubectl apply -f deploy/kubernetes/deploy.yaml"
        //     }
        // }
        // stage ('Apply Ingress') {
        //     steps {
        //         sh "kubectl apply -f deploy/kubernetes/ingress.yaml"
        //     }
        // }
    }
}