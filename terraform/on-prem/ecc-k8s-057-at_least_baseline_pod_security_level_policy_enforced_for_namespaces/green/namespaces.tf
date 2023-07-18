resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule                        = "ecc-k8s-057-at_least_baseline_pod_security_level_policy_enforc"
      ComplianceStatus                     = "Green"
      "pod-security.kubernetes.io/enforce" = "baseline"
    }
    name = "namespace-057-green"
  }
}

resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i  \\'/- --enable-admission-plugins=.*/ s/$/,PodSecurity/\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/- --enable-admission-plugins=.*/ s/,PodSecurity//g\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}