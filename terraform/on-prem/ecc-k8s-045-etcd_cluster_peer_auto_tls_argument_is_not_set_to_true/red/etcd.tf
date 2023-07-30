resource "null_resource" "deploy_cluster" {

  provisioner "local-exec" {
    command     = "kind create cluster --config  kind-config.yaml && sleep 30"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "kind delete cluster -n cluster-045-red"
    interpreter = ["/bin/bash", "-c"]
  }
}


resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
        kubectl config set-context  kind-cluster-045-red
        kind_control_plane_1_id=`docker ps | grep cluster-045-red-control-plane$ | awk '{print $1}'`
        echo "$kind_control_plane_1_id"
        kind_control_plane_2_id=`docker ps | grep cluster-045-red-control-plane2 | awk '{print $1}'`
        echo "$kind_control_plane_2_id"

        for VARIABLE in $kind_control_plane_1_id $kind_control_plane_2_id
            do
                docker exec $VARIABLE sed -i '/- etcd/a\    - --peer-auto-tls' /etc/kubernetes/manifests/etcd.yaml
                docker exec $VARIABLE sed -i '/--peer-cert-file/d' /etc/kubernetes/manifests/etcd.yaml
                docker exec $VARIABLE sed -i '/--peer-key-file/d' /etc/kubernetes/manifests/etcd.yaml
                docker exec $VARIABLE sed -i '/--peer-trusted-ca-file/d' /etc/kubernetes/manifests/etcd.yaml
                docker exec $VARIABLE sed -i '/--peer-client-cert-auth=true/d' /etc/kubernetes/manifests/etcd.yaml
                echo "Manifect for $VARIABLE was updated"
            done
        sleep 100
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [null_resource.deploy_cluster]
}


               