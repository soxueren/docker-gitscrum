#!/bin/bash
kubectl create configmap cloud-config --from-file=./config/ --namespace=$NAMESPACE  -s $K8S_HOST  --token="$KUBE_TOKEN"
