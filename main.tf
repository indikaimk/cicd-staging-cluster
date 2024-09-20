terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.41.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.15.0"
    }
  }
}

resource "random_id" "cluster_name" {
  byte_length = 5
}

locals {
  cluster_name = "staging-cluster-${random_id.cluster_name.hex}"
}

module "staging-cluster" {
  source             = "./staging-cluster"
  cluster_name       = local.cluster_name
  cluster_region     = "sgp1"
  cluster_version    = var.cluster_version

  worker_size        = var.worker_size
  worker_count       = var.worker_count
}

module "argo-cd" {
  source           = "./kubernetes-argocd"
  cluster_name     = module.staging-cluster.cluster_name
  cluster_id       = module.staging-cluster.cluster_id
}