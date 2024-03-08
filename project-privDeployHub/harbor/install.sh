#!/bin/bash

# 스크립트 파일의 디렉토리로 작업 디렉토리 변경
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR" || exit

# OpenEBS-hostpath StorageClass를 기본 StorageClass로 지정
kubectl patch storageclass openebs-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# Harbor 설치 (Helm 이용)
kubectl create ns harbor
kubectl config set-context --current --namespace=harbor
helm install harbor . --namespace harbor -f my-values.yaml

# /etc/hosts에 harbor.myweb.io 도메인 추가
# 이 작업은 스크립트를 실행하는 시스템에만 적용됩니다.
echo "192.168.32.75 harbor.myweb.io" | sudo tee -a /etc/hosts > /dev/null

# 모든 노드에 대해 위의 /etc/hosts 변경 작업을 수동으로 반복해야 합니다.