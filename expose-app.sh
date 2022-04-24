#!/bin/sh
POD_NAME=$(kubectl get pods --namespace zuhairalzikri -l "app=my-python-image" -o jsonpath="{.items[0].metadata.name}")
echo "Visit http://localhost:9000 to use the application"
kubectl port-forward $POD_NAME 9000:8002 --namespace zuhairalzikri 

