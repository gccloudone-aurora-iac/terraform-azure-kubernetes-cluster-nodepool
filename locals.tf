locals {
  tags = merge(var.tags, { ModuleName = "terraform-azure-kubernetes-cluster-nodepool" }, { ModuleVersion = "v1.0.0" })
}
