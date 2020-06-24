
variable "subnet_id" {
  description = "The id of the existing subnet for nodes"
}

variable "node_resource_group_name" {
  description = "The name of the resource group where AKS nodes resides"
}

variable "location" {
  description = "The location of cluster resources. This also where the nsg resides"
}