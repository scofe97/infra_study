#!/bin/bash

# 스크립트 파일의 디렉토리로 작업 디렉토리 변경
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR" || exit

kubectl create ns argocd
kubectl config set-context --current --namespace=argocd
helm install argocd  . --namespace argocd -f my-values.yaml

sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

