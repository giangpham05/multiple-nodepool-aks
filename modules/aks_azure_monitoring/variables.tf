variable log_analytics_workspace_name {
  description = "The name of the Log Analytics workspace"
  default     = "Log-Analytics-Workspace"
}

variable log_analytics_workspace_location {
  description = "The location of the Log Analytics workspace"
  default     = "australiaeast"
}

variable log_analytics_workspace_resource_group {
  description = "The resource group where the Log Analytics workspace resides"
}

variable log_analytics_workspace_sku {
  description = "The SKU for Log Analytics workspace"
  default     = "PerGB2018"
}