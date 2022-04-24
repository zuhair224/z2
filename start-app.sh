#!/bin/sh
echo 'Creating namespace...'
kubectl create -f ./namespace.yaml
kubectl create -f ./statefulset.yaml
kubectl create -f ./statefulset-service.yaml
kubectl create -f ./deployment.yml 
kubectl create -f ./service.yml 
