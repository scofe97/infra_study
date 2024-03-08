#!/bin/bash

# 스크립트 파일의 디렉토리로 작업 디렉토리 변경
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR" || exit

kubectl create ns metallb
kubectl config set-context --current --namespace=metallb
helm install metallb . --namespace metallb -f my-values.yaml --wait

kubectl apply -f L2Advertisement.yaml
kubectl apply -f IPAddressPool.yaml 