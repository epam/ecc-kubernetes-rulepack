cat > /var/lib/minikube/certs/encryption_config.yml << EOF
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
    - secrets
    providers:
    - aescbc:
        keys:
        - name: key1
          secret: +H3URCtXK2NSVdU6ugnAL1p5RT4Ytfyeirl0wPLMqAo=
    - identity: {}
EOF


sed -i '/- kube-apiserver.*/a\    - --encryption-provider-config=/var/lib/minikube/certs/encryption_config.yml\' /etc/kubernetes/manifests/kube-apiserver.yaml