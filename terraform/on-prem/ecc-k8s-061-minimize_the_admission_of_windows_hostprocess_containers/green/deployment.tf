/*
  Before deploying infrastructure for the rule, you should create Kubernetes cluster with the terraform scripts in the 'cluster' folder.
  This will create and configure a Kubernetes cluster with master node on Linux Ubuntu 22.04 Server and worker node on Windows Server 2019. Connection to this instances will be allowed only from your public IP assigned to you by ISP.

  1. Navigate to ./cluster and execute 'terraform apply'. 
  2. After terraform deployed resources wait about 10-15 minuts, while cluster is being set up. 
  3. Connect to master node using its public IP (can be found in terraform output) and password 'kubeadmin'.
  4. Check that Windows worker node was connected: "k get nodes".
  5. Check that all pods are running: "k get pods -A".
  6. (Optional) Connect to worker node:
    3.1 Get Windows password by executing command: terraform output administrator_password.
    3.2 Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
    3.3 In the navigation pane, select 'Instances'. Select the instance and then choose 'Connect'.
    3.4 On the 'Connect to instance' page,choose 'Download remote desktop file'. When you have finished downloading the file, open it and you'll see the 'Remote Desktop Connection' dialog box.
    3.5 You may get a warning that the publisher of the remote connection is unknown. Choose 'Connect' to continue to connect to your instance.
    3.6 The administrator account is chosen by default. Copy and paste the password that you saved previously from step 3.1.
    3.7 Due to the nature of self-signed certificates, you may get a warning that the security certificate could not be authenticated. Use the following steps to verify the identity of the remote computer, or simply choose 'Yes' (Windows) if you trust the certificate.
  7. After you've connected to master node, you can copy there terraform files to deploy gree/red infrastructure. Terraform will be already installed.
  8. Start deploying infrastructure. 
*/


resource "kubernetes_manifest" "this" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))
}
