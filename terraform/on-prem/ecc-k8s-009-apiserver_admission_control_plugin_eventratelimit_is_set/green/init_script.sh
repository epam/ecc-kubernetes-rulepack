cat > /etc/kubernetes/admission-control-config.yaml << EOF
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
  - name: EventRateLimit
    configuration:
      apiVersion: eventratelimit.admission.k8s.io/v1alpha1
      kind: Configuration
      limits:
        - burst: 3000
          qps: 6000
          type: Namespace
EOF

cp /etc/kubernetes/manifests/kube-apiserver.yaml .

cat > volumeMounts.tmp << EOF
    - mountPath: /etc/kubernetes/admission-control-config.yaml
      name: admission-control-config
      readOnly: true
EOF

cat > volumes.tmp << EOF
  - hostPath:
      path: /etc/kubernetes/admission-control-config.yaml
      type: File
    name: admission-control-config
EOF

sed -i '/volumeMounts:/r volumeMounts.tmp' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumes:/r volumes.tmp' /etc/kubernetes/manifests/kube-apiserver.yaml

sed -i  '/- --enable-admission-plugins=.*/ s/$/,EventRateLimit/' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i  '/--enable-admission-plugins=.*/a\    - --admission-control-config-file=/etc/kubernetes/admission-control-config.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml

rm volumes.tmp volumeMounts.tmp