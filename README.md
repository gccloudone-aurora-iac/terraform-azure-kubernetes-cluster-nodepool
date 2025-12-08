# terraform-azurerm-kubernetes-cluster-nodepool

This repository contains an opionionated Terraform module that can be used to provision a Kubernetes Node Pool.

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.26.0 |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | The ID of the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the node pool | `string` | n/a | yes |
| <a name="input_auto_scaling_max_nodes"></a> [auto\_scaling\_max\_nodes](#input\_auto\_scaling\_max\_nodes) | The maximum number of nodes which should exist within this Node Pool. | `number` | `3` | no |
| <a name="input_auto_scaling_min_nodes"></a> [auto\_scaling\_min\_nodes](#input\_auto\_scaling\_min\_nodes) | The minimum number of nodes which should exist within this Node Pool. | `number` | `0` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. | `list(string)` | `null` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | n/a | `bool` | `false` | no |
| <a name="input_enable_host_encryption"></a> [enable\_host\_encryption](#input\_enable\_host\_encryption) | Should the nodes in this Node Pool have host encryption enabled? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete. | `string` | `"Delete"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes used for the Agents. | `string` | `null` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | The maximum number of pods that can run on each agent. | `number` | `60` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | If enable\_auto\_scaling = false, it is the number of nodes which should exist within this Node Pool. Otherwise, it is the initial number of nodes to set. | `number` | `null` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | A map of Kubernetes labels which should be applied to nodes in this Node Pool. | `map(string)` | `{}` | no |
| <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints) | A list of Kubernetes taints which should be applied to nodes in the agent pool. | `list(string)` | `[]` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The Agent Operating System disk size in GB. Changing this forces a new resource to be created. | `number` | `256` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. | `string` | `"Managed"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The Operating System which should be used for this Node Pool. Possible values are Linux and Windows. | `string` | `"Linux"` | no |
| <a name="input_pod_subnet_id"></a> [pod\_subnet\_id](#input\_pod\_subnet\_id) | The ID of the Subnet where the pods in the Node Pool should exist. | `string` | `null` | no |
| <a name="input_spot_max_price"></a> [spot\_max\_price](#input\_spot\_max\_price) | The maximum price you're willing to pay in USD per Virtual Machine. Valid values are -1 (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places. | `string` | `"-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_upgrade_max_surge"></a> [upgrade\_max\_surge](#input\_upgrade\_max\_surge) | The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. | `string` | `"33%"` | no |
| <a name="input_vm_priority"></a> [vm\_priority](#input\_vm\_priority) | The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. | `string` | `"Regular"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The SKU which should be used for the Virtual Machines used in this Node Pool. | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | The ID of the Subnet where this Node Pool should exist. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the created Kubernetes Cluster Node Pool. |
<!-- END_TF_DOCS -->

## History

| Date       | Release | Change                                                                                           |
| ---------- | ------- | ------------------------------------------------------------------------------------------------ |
| 2025-01-25 | v1.0.0  | initial commit                                                                                   |
| 2025-10-20 | v2.0.1  | Pin minimum version of azurerm to 4.49.0                                                         |
| 2025-12-08 | v2.0.2  | Added support for `os_sku` to default node pool                                                  |
