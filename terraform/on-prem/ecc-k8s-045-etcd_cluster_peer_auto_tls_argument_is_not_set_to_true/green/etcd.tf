# 1. Install kind to deploy this infrastructure
# 2. Create cluster: kind create cluster  --config kind-config.yaml
# 3. Set up context: kubectl config rename-context kind-kind c7n
#    Note: If you already have context named c7n, rename it temporary:  kubectl config rename-context c7n c7n_temp
# 4. (Optionally) Set as current: kubectl config  use-context c7n && kubectl config get-contexts
# 5. Deploy terraform: terraform init && terraform apply --auto-approve
# 6. Destroy terraform: terraform destroy --auto-approve
# 7. Delete cluster: kind delete cluster
# 8. Set up context: kubectl config unset contexts.c7n &&  kubectl config rename-context c7n_temp c7n 


resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
        kind_control_plane_1_id=`docker ps | grep kind-control-plane$ | awk '{print $1}'`
        kind_control_plane_2_id=`docker ps | grep kind-control-plane2 | awk '{print $1}'`
        docker exec $kind_control_plane_1_id sed -i '/- etcd/a\    - --peer-auto-tls=false' /etc/kubernetes/manifests/etcd.yaml
        docker exec $kind_control_plane_2_id sed -i '/- etcd/a\    - --peer-auto-tls=false' /etc/kubernetes/manifests/etcd.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
        kind_control_plane_1_id=`docker ps | grep kind-control-plane$ | awk '{print $1}'`
        kind_control_plane_2_id=`docker ps | grep kind-control-plane2 | awk '{print $1}'`
        docker exec $kind_control_plane_1_id sed -i '/--peer-auto-tls/d' /etc/kubernetes/manifests/etcd.yaml
        docker exec $kind_control_plane_2_id sed -i '/--peer-auto-tls/d' /etc/kubernetes/manifests/etcd.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}


               