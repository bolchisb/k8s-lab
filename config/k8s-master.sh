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

kubeadm init \
  --pod-network-cidr=10.41.0.0/16 \
  --ignore-preflight-errors=all \
  --service-dns-domain=us-west-01.codeops.net \
  --apiserver-advertise-address=10.145.0.11

echo "sleeping 10 seconds"
sleep 10

rm -rf /home/vagrant/.kube

mkdir /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube -R

echo "sleeping 30 seconds"
sleep 30

kubectl get nodes