# k8s-lab
A K8s laboratory based on vagrant. Quick solution to learn and experiment with kubernetes.
# Dashboard deploy

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
```

You can enable access to the Dashboard using the kubectl command-line tool, by running the following command:
```bash
kubectl proxy
```

# Network setup
The last part is networking. Installing Calico

```bash
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
wget https://docs.projectcalico.org/manifests/custom-resources.yaml 
vi custom-resources.yaml
kubectl create -f custom-resources.yaml
```

In the `kubeadm init` command I specified the pod CIDR `--pod-network-cidr=10.41.0.0/16`, we need to specify the same CIDR as below.
```yaml
 ipPools:
    - blockSize: 26
      cidr: 10.41.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()
```