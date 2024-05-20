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
        stage ('Apply MySqlDeployment') {
            steps {
                script {
                    kubernetesDeploy(configs: 'deploy/kubernetes/mysql-config.yaml', kubeconfigId: 'mykubecred', enableConfigSubstitution: true, enableSubstitution: true, showLogs: true, verbose: true, wait: true, namespace: 'default')
                    kubernetesDeploy(configs: 'deploy/kubernetes/mysql.yaml', kubeconfigId: 'mykubecred', enableConfigSubstitution: true, enableSubstitution: true, showLogs: true, verbose: true, wait: true, namespace: 'default')
                }
            }
        }
        stage ('Apply Deployment') {
            steps {
                script {
                    kubernetesDeploy(configs: 'deploy/kubernetes/deploy.yaml', kubeconfigId: 'mykubecred', enableConfigSubstitution: true, enableSubstitution: true, showLogs: true, verbose: true, wait: true, namespace: 'default')
                }
            }
        }
        stage ('Apply Ingress') {
            steps {
                script {
                    kubernetesDeploy(configs: 'deploy/kubernetes/ingress.yaml', kubeconfigId: 'mykubecred', enableConfigSubstitution: true, enableSubstitution: true, showLogs: true, verbose: true, wait: true, namespace: 'default')
                }
            }
        }
    }
}