#!/bin/bash

# 스크립트 파일의 디렉토리로 작업 디렉토리 변경
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR" || exit

kubectl create ns nginx
kubectl config set-context --current --namespace=nginx
helm install nginx  . --namespace nginx -f my-values.yaml --wait