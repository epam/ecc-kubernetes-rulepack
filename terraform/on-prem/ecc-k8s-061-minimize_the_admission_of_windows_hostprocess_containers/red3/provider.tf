terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig-path
  config_context = var.context
}
