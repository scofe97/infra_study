#!/bin/bash

# Helm의 공개 키 추가
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

# apt-transport-https 설치
sudo apt-get install apt-transport-https --yes

# Helm 저장소 추가
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# 패키지 목록 업데이트 및 Helm 설치
sudo apt-get update
sudo apt-get install helm -y

# Java 설치
sudo apt update
sudo apt install openjdk-17-jdk -y

# JAVA_HOME 환경변수 설정
JAVA_HOME=$(update-java-alternatives -l | awk '{print $3}')
echo "export JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile

echo "shell을 재시작하거나 'source /etc/profile'명령어를 실행해야 JAVA_HOME이 변경됩니다."


# >>> krew 설치
{
  set -x
  cd "$(mktemp -d)" || exit
  OS="$(uname | tr '[:upper:]' '[:lower:]')"
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
  KREW="krew-${OS}_${ARCH}"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
  tar zxvf "${KREW}.tar.gz"
  ./"${KREW}" install krew
}

# PATH 설정을 ~/.bashrc에 추가
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ~/.bashrc

# ~/.bashrc를 재실행하여 PATH 변경 적용
source ~/.bashrc

# Krew 플러그인 설치
kubectl krew install ctx
kubectl krew install ns