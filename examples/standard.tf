#####################
### Prerequisites ###
#####################

provider "azurerm" {
  features {}
}

# Manages an Azure Resource Group.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
#
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "Canada Central"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
  }
}

###################################
### Kubernetes Node Pool Module ###
###################################

# Invokes the terraform-azurerm-kubernetes-cluster-nodepool module used to create a Node Pool within a Kubernetes Cluster.
#
# https://github.com/gccloudone-aurora-iac/terraform-azure-kubernetes-cluster-nodepool
#
module "internal_node_pool" {
  source = "../"

  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_DS2_v2"
  vm_priority           = "Spot"
  node_count            = 1

  vnet_subnet_id = azurerm_subnet.example.id
  pod_subnet_id  = azurerm_subnet.example.id

  tags = {
    Environment = "Development"
  }
}
