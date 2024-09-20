terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.41.0"
    }
  }
}

data "digitalocean_kubernetes_versions" "current" {

}

resource "digitalocean_kubernetes_cluster" "staging" {
  name    = var.cluster_name
  region  = var.cluster_region
  version = data.digitalocean_kubernetes_versions.current.latest_version

  node_pool {
    name       = "default"
    size       = var.worker_size
    node_count = var.worker_count
  }
}