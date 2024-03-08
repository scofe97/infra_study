#!/bin/bash

# OpenEBS 네임스페이스 생성
kubectl create ns openebs

# 컨텍스트의 네임스페이스를 'openebs'로 변경
# 'kubectl ns'는 표준 명령이 아니며, 일부 환경에서는 작동하지 않을 수 있습니다.
# 아래 명령은 현재 컨텍스트의 네임스페이스를 'openebs'로 설정합니다.
kubectl config set-context --current --namespace=openebs

# OpenEBS 매니페스트 적용
kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
