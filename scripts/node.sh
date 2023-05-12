systemctl daemon-reload && systemctl restart kubelet
# sudo swapoff -a && sudo systemctl daemon-reload && sudo systemctl restart kubelet

sudo kubeadm join 172.16.171.131:6443 --cri-socket=unix:///var/run/cri-dockerd.sock --token tvhky3.ueaskpdj47efoc55 --discovery-token-ca-cert-hash sha256:e76f6b6c88dea3988a14c6986b348fd7643e2a7873ccdab46d16d1560da77ed4 