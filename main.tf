# Manages a Node Pool within a Kubernetes Cluster.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
#
resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = var.name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  orchestrator_version  = var.kubernetes_version
  zones                 = var.availability_zones

  # Network configuration
  vnet_subnet_id        = var.vnet_subnet_id
  pod_subnet_id         = var.pod_subnet_id
  enable_node_public_ip = false

  # Node configuration
  vm_size     = var.vm_size
  os_type     = var.os_type
  node_labels = var.node_labels
  node_taints = var.node_taints
  max_pods    = var.max_pods

  # Node priority configuration
  priority        = var.vm_priority
  eviction_policy = var.vm_priority == "Spot" ? var.eviction_policy : null
  spot_max_price  = var.vm_priority == "Spot" ? var.spot_max_price : null

  # Autoscaling
  node_count          = !var.enable_auto_scaling ? var.node_count : null
  enable_auto_scaling = var.enable_auto_scaling
  min_count           = var.enable_auto_scaling ? var.auto_scaling_min_nodes : null
  max_count           = var.enable_auto_scaling ? var.auto_scaling_max_nodes : null

  # Disk configuration
  enable_host_encryption = var.enable_host_encryption
  os_disk_size_gb        = var.os_disk_size_gb
  os_disk_type           = var.os_disk_type

  # Upgrade configuration
  dynamic "upgrade_settings" {
    for_each = var.vm_priority != "Spot" ? ["upgrade_settings"] : []

    content {
      drain_timeout_in_minutes      = var.upgrade_settings.drain_timeout_in_minutes
      node_soak_duration_in_minutes = var.upgrade_settings.node_soak_duration_in_minutes
      max_surge                     = var.upgrade_settings.max_surge
    }
  }

  # Permit ("System") or deny ("User") the scheduling of critical system pods
  mode = var.mode

  tags = local.tags
}
