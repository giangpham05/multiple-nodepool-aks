resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "la_workspace" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = var.log_analytics_workspace_resource_group
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "la_solution" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.la_workspace.location
    resource_group_name   = azurerm_log_analytics_workspace.la_workspace.resource_group_name
    workspace_resource_id = azurerm_log_analytics_workspace.la_workspace.id
    workspace_name        = azurerm_log_analytics_workspace.la_workspace.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}
