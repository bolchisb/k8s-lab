#!/bin/bash

mkdir /etc/docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "1"
  },
  "storage-driver": "overlay2"
}
EOF

apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl https://get.docker.com | bash

apt-get install -y kubelet kubeadm kubectl

systemctl daemon-reload
systemctl enable kubelet
systemctl start kubelet
systemctl status kubelet
