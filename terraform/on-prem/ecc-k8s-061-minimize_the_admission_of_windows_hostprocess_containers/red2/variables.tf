variable "context" {
  type        = string
  description = "Context name to use to access a cluster"
}

variable "kubeconfig-path" {
  type        = string
  description = "Path to kubeconfig file to find the information Terraform needs to choose a cluster and communicate with the API server of a cluster"
}
