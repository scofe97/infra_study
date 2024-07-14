#!/bin/bash

# 스크립트 파일의 디렉토리로 작업 디렉토리 변경
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR" || exit

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

sleep 5
kubectl get -n kube-system deploy metrics-server -o yaml | kubectl neat > metrics-insecure-deploy.yaml
echo "args에 --kubelet-insecure-tls추가해야함"

kubectl create ns monitoring
kubectl config set-context --current --namespace=monitoring
helm install prometheus  . --namespace monitoring -f my-values.yaml --wait
