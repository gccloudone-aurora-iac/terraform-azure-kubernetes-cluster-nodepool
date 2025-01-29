output "id" {
  description = "The id of the created Kubernetes Cluster Node Pool."
  value       = azurerm_kubernetes_cluster_node_pool.this.id
}
