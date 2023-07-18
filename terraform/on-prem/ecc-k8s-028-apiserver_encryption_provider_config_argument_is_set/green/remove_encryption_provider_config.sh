sed -i '/^    - --encryption-provider-config=\/var\/lib\/minikube\/certs\/encryption_config.yml/d' /etc/kubernetes/manifests/kube-apiserver.yaml

rm /var/lib/minikube/certs/encryption_config.yml