######################
### Azure Resource ###
######################

variable "name" {
  description = "The name of the node pool"
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

##########################
### Cluster Versioning ###
##########################

variable "kubernetes_version" {
  description = "The version of Kubernetes used for the Agents."
  type        = string
  default     = null
}

################################
### Networking Configuration ###
################################

variable "pod_subnet_id" {
  description = "The ID of the Subnet where the pods in the Node Pool should exist."
  type        = string
  default     = null
}

variable "vnet_subnet_id" {
  description = "The ID of the Subnet where this Node Pool should exist."
  type        = string
  default     = null
}

##########################
### Node Configuration ###
##########################

variable "vm_size" {
  description = "The SKU which should be used for the Virtual Machines used in this Node Pool."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "os_type" {
  description = "The Operating System which should be used for this Node Pool. Possible values are Linux and Windows."
  type        = string
  default     = "Linux"
}

variable "availability_zones" {
  description = " Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located."
  type        = list(string)
  default     = null
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent."
  type        = number
  default     = 60
}

variable "node_labels" {
  description = "A map of Kubernetes labels which should be applied to nodes in this Node Pool."
  type        = map(string)
  default     = {}
}

variable "node_taints" {
  description = "A list of Kubernetes taints which should be applied to nodes in the agent pool."
  type        = list(string)
  default     = []
}

###################################
### Node Priority Configuration ###
###################################

variable "vm_priority" {
  description = "The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot."
  type        = string
  default     = "Regular"
}

variable "eviction_policy" {
  description = "The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete."
  type        = string
  default     = "Delete"
}

variable "spot_max_price" {
  description = "The maximum price you're willing to pay in USD per Virtual Machine. Valid values are -1 (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places."
  type        = string
  default     = "-1"
}

##################
### Node Count ###
##################

variable "node_count" {
  description = "If enable_auto_scaling = false, it is the number of nodes which should exist within this Node Pool. Otherwise, it is the initial number of nodes to set."
  type        = number
  default     = null
}

variable "enable_auto_scaling" {
  description = ""
  type        = bool
  default     = false
}

variable "auto_scaling_min_nodes" {
  description = "The minimum number of nodes which should exist within this Node Pool."
  type        = number
  default     = 0
}

variable "auto_scaling_max_nodes" {
  description = "The maximum number of nodes which should exist within this Node Pool."
  type        = number
  default     = 3
}

##########################
### Disk Configuration ###
##########################

variable "enable_host_encryption" {
  description = "Should the nodes in this Node Pool have host encryption enabled? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "os_disk_size_gb" {
  description = "The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
  type        = number
  default     = 256
}

variable "os_disk_type" {
  description = "The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type        = string
  default     = "Managed"
}

#############################
### Upgrade Configuration ###
#############################

# Max Surge: The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade 
variable "upgrade_settings" {
  description = "Node pool upgrade settings"
  type = object({
    drain_timeout_in_minutes      = optional(number, 30)
    node_soak_duration_in_minutes = optional(number, 0)
    max_surge                     = optional(string, "33%") // "The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade."
  })
  default = {
    drain_timeout_in_minutes      = 30
    node_soak_duration_in_minutes = 0
    max_surge                     = "33%"
  }
}

############
### Mode ###
############

# See https://learn.microsoft.com/en-us/azure/aks/use-system-pools
variable "mode" {
  description = "When set to System, permits the scheduling of critical system pods onto nodes in this Node Pool"
  type        = string
  default     = "User"
}
