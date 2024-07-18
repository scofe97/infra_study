#!/bin/bash

# NVM 디렉토리
NVM_DIR="$HOME/.nvm"

# NVM 관련 파일 및 디렉토리 삭제
if [ -d "$NVM_DIR" ]; then
  echo "Removing NVM directory..."
  rm -rf "$NVM_DIR"
fi

# 쉘 프로파일에서 NVM 관련 라인 제거
echo "Removing NVM lines from shell profile files..."

# .bashrc 파일에서 제거
if [ -f "$HOME/.bashrc" ]; then
  sed -i '/NVM_DIR/d' "$HOME/.bashrc"
  sed -i '/nvm.sh/d' "$HOME/.bashrc"
fi

# .zshrc 파일에서 제거
if [ -f "$HOME/.zshrc" ]; then
  sed -i '/NVM_DIR/d' "$HOME/.zshrc"
  sed -i '/nvm.sh/d' "$HOME/.zshrc"
fi

# .profile 파일에서 제거
if [ -f "$HOME/.profile" ]; then
  sed -i '/NVM_DIR/d' "$HOME/.profile"
  sed -i '/nvm.sh/d' "$HOME/.profile"
fi

# .bash_profile 파일에서 제거
if [ -f "$HOME/.bash_profile" ]; then
  sed -i '/NVM_DIR/d' "$HOME/.bash_profile"
  sed -i '/nvm.sh/d' "$HOME/.bash_profile"
fi

# 확인 메시지
echo "NVM has been removed from your system."

