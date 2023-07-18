cat > /etc/kubernetes/token-auth-file.csv << EOF
token-002-red,user-002-red,uid-002-red,"group-002-red"
EOF

cp /etc/kubernetes/manifests/kube-apiserver.yaml .

cat > volumeMounts.tmp << EOF
    - mountPath: /etc/kubernetes/token-auth-file.csv
      name: token-auth-file
      readOnly: true
EOF

cat > volumes.tmp << EOF
  - hostPath:
      path: /etc/kubernetes/token-auth-file.csv
      type: File
    name: token-auth-file
EOF

sed -i  '/- kube-apiserver.*/a\    - --token-auth-file=/etc/kubernetes/token-auth-file.csv' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumeMounts:/r volumeMounts.tmp' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumes:/r volumes.tmp' /etc/kubernetes/manifests/kube-apiserver.yaml

rm volumes.tmp volumeMounts.tmp