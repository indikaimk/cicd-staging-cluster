output "cluster_id" {
  value = digitalocean_kubernetes_cluster.staging.id
}

output "cluster_name" {
  value = digitalocean_kubernetes_cluster.staging.name
}