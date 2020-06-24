variable "ssh_public_key" {
    default = "C:/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    description = "The DNS prefix for the cluster"
}

variable "location" {
  description = "Azure location to deploy resources"
}

variable "cluster_name" {
  description = "AKS cluster name"
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy AKS cluster in"
}

variable "kubernetes_version" {
  description = "Version of the kubernetes cluster"
}

variable "vnet_subnet_id" {
  description = "vnet id where the nodes will be deployed"
}

#Network Profile config
variable "network_plugin" {
  description = "Network plugin for kubenretes network overlay (azure or calico)"
  default     = "azure"
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP address"
  default = "10.240.238.10"
}

variable "service_cidr" {
  description = "Kubernetes service address range. This range should not be used by any network element on or connected to this virtual network. Service address CIDR must be smaller than /12."
  default     = "10.240.238.0/23"
}

variable "docker_bridge_cidr" {
  description = "Docker bridge address"
  default     = "172.17.0.1/16"
}

variable "diagnostics_workspace_id" {
  description = "Log analytics workspace id for cluster audit"
}

variable "client_app_id" {}

variable "server_app_secret" {}

variable "server_app_id" {}

variable "tenant_id" {}

variable "default_node_pool" {
  description = "The object to configure the default node pool with number of worker nodes, worker node VM size and Availability Zones."
  type = object({
    name                           = string
    node_count                     = number
    vm_size                        = string
    enable_auto_scaling            = bool
    min_count                      = number
    max_count                      = number
    enable_node_public_ip          = bool
    max_pods                       = number
    os_disk_size_gb                = number
    agent_pool_type                = string
  })
  default = {
      name = "mainnp"
      node_count = 2
      vm_size = "Standard_D2s_v3"
      enable_auto_scaling = true
      enable_node_public_ip = false
      min_count = 1
      max_count = 5
      max_pods               = 100
      os_disk_size_gb = 128
      agent_pool_type = "VirtualMachineScaleSets"
  }
}

variable "win_node_pool" {
  description = "win_node_pool"
  type = object({
    name                           = string
    node_count                     = number
    node_os                        = string
    vm_size                        = string
    enable_auto_scaling            = bool
    min_count                      = number
    max_count                      = number
    enable_node_public_ip          = bool
    max_pods                       = number
    os_disk_size_gb                = number
    agent_pool_type                = string
  })
  default = {
      name                         = "winnp"
      node_count                   = 1
      node_os                      = "Windows"
      vm_size                      = "Standard_D2s_v3"
      enable_auto_scaling          = true
      enable_node_public_ip        = false
      min_count                    = 1
      max_count                    = 5
      max_pods                     = 100
      os_disk_size_gb              = 128
      agent_pool_type              = "VirtualMachineScaleSets"
    }
}