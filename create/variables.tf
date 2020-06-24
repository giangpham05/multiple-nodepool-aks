variable cluster_name {
  description = "AKS cluster name"
  default     = "aks-cluster"
}

variable "dns_prefix" {
    description = "The DNS prefix for AKS cluster"
    default = "aks-cluster-dns"
}

variable "kubernetes_version" {
    description = "The version of kubernetes"
    default = "1.16.9"
}

variable resource_group_name {
  description = "The name of the resource group where AKS resources reside"
  default     = "resource-group-kubernetes"
}

variable location {
  description = "Azure location to deploy resources"
  default = "Australia East"
}

variable "client_app_id" {
  description = "The service principal id of client app. AKS uses this SP to create the required resources."
  default     = ".....5e91"
}

variable server_app_id {
  description = "The service principal id of server app. AKS uses this SP to create the required resources."
  default     = "c3....2177"
}

variable server_app_secret {
  description = "The service principal secret of server app. AKS uses this SP to create the required resources."
  default     = ".......4kH."
}

variable tenant_id  {
  description = "The tenant id of Diamond Azure subscription."
  default     = "885......d3b3"
}

variable vnet_subnet_id {
    default = "/subscriptions/4.........71/resourceGroups/DIT_VNet/providers/Microsoft.Network/virtualNetworks/DTGVNet/subnets/your_subnet"
}