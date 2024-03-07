#!/bin/bash

echo ">>> INIT MASTER NODE"
sudo systemctl enable kubelet

kubeadm reset
kubeadm init \
  --apiserver-advertise-address=$MASTER_NODE_IP \
  --control-plane-endpoint $MASTER_NODE_IP \
  --pod-network-cidr=$K8S_POD_NETWORK_CIDR \
  --v=5

echo ">>> CONFIGURE KUBECTL"
sudo mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


echo ">>> INSTALL NETWORK ADDON (CANAL)"
kubectl apply -f https://docs.projectcalico.org/archive/v3.25/manifests/calico.yaml

echo ">>> GET WORKER JOIN COMMAND "
rm -f /vagrant/kubeadm/init-worker.sh
kubeadm token create --print-join-command >> /vagrant/kubeadm/init-worker.sh
