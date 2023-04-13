#! /bin/bash

MASTER_IP="192.168.64.6"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

sudo kubeadm config images pull

echo "Preflight Check Passed: Downloaded All Required Images"

sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=Mem

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config   

# Generete kubeadm join command
kubeadm token create --print-join-command

# Install Calico Network plugin
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml

