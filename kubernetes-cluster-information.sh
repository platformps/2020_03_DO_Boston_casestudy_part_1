#!/bin/sh

exec > kubernetes-cluster-information-output 2>&1

POD_NAMES=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
DEPLOYMENT="git-ansible-vb-k8-docker-jenkins"
SERVICE="git-ansible-vb-k8-docker-jenkins-svc"

echo "***************
Get Namespaces:
***************"
kubectl get namespaces
echo
echo "********************
Describe Namespaces:
********************"
kubectl describe namespaces

echo
echo "**********
Get Nodes:
**********"
kubectl get nodes
echo
echo "***************
Describe Nodes:
***************"
kubectl describe nodes

echo
echo "*************
Get Services:
*************"
kubectl get services $SERVICE
echo
echo "******************
Descrube Services:
******************"
kubectl describe services $SERVICE

echo
echo "*********
Get Pods:
*********"
kubectl get pods -o wide $POD_NAMES
echo
echo "**************
Describe Pods:
**************"
kubectl describe pods $POD_NAMES

echo
echo "****************
Get ReplicaSets:
****************"
kubectl get replicaSets
echo
echo "*********************
Describe ReplicaSets:
*********************"
kubectl describe replicaSets

echo
echo "***************
Get Deployment:
***************"
kubectl get deployments $DEPLOYMENT
echo
echo "********************
Describe Deployment:
********************"
kubectl describe deployments $DEPLOYMENT

echo
echo "**********************
Get Deployment Events:
**********************"
kubectl get events | grep $DEPLOYMENT
echo
echo "***************************
Describe Deployment Events:
***************************"
kubectl describe events | grep $DEPLOYMENT

echo
echo "**************************
Get Environment Variables:
**************************"
for POD in $POD_NAMES
do
	echo "*********************************************************
$POD\'s Environment Variables:
*********************************************************
"
	env
	echo
done
