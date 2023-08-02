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
    command     = <<CMD
        kind_control_plane_1_id=`docker ps | grep "control-plane$" | awk '{print $1}'`
        echo "$kind_control_plane_1_id"
        docker exec $kind_control_plane_1_id sed -i '/- --enable-admission-plugins=.*/ s/$/,PodSecurity/' /etc/kubernetes/manifests/kube-apiserver.yaml
        echo "Manifect for $kind_control_plane_1_id was updated"
        sleep 90
    CMD
    
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
        kind_control_plane_1_id=`docker ps | grep "control-plane$" | awk '{print $1}'`
        echo "$kind_control_plane_1_id"
        docker exec $kind_control_plane_1_id sed -i '/- --enable-admission-plugins=.*/ s/,PodSecurity//g' /etc/kubernetes/manifests/kube-apiserver.yaml && echo "Manifect for $kind_control_plane_1_id was updated"
        sleep 90
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [kubernetes_namespace_v1.this] 
}