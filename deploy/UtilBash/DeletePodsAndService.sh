# Bash script to delete all pods and services in a namespace
# Usage: ./DeletePodsAndService.sh <namespace>

#!/bin/bash

# Set the KUBECONFIG environment variable with the path to the kubeconfig file
# export KUBECONFIG=$PWD/../../../../../.kube/config
export KUBECONFIG=$HOME/.kube/config 

# Check root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi
}

print_comment()
{
    echo " "
    echo "****************************************************************************************"
    echo "*--> $1 *"
    echo "****************************************************************************************"
    echo " "
}

# print_comment $KUBECONFIG

# Function that receive parameters for the type to be deleted and the name
deleteResource() {

    print_comment "Deleting, kubectl delete $1 $2"

    kubectl delete $1 $2 # -n $

    # Check if the resource was deleted

    if [ $? -eq 0 ]; then
        echo "$1 $2 deleted successfully"
    else
        echo "$1 $2 was not deleted"
    fi
}

# Variables with the names 
ingressName="myapp-ingress"
appServiceName="myapp-service"
mysqlServiceName="mysql-service"
deploymentName="myapp-deployment"
mysqlDeploymentName="mysql-deployment"
configMapName="mysql-config"

# Check if the user is root
# check_root

# Delete the ingress
deleteResource ingress $ingressName

# Delete the services
deleteResource service $appServiceName
deleteResource service $mysqlServiceName

# Delete the deployments
deleteResource deployment $deploymentName
deleteResource deployment $mysqlDeploymentName

# Delete the config map
deleteResource ConfigMap $configMapName
