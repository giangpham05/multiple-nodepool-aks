resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
    prevent_destroy = false
  }

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  # node_resource_group = var.resource_group_name

  default_node_pool {
    name                  = substr(var.default_node_pool.name, 0, 12)
    node_count            = var.default_node_pool.node_count
    max_count             = var.default_node_pool.max_count
    min_count             = var.default_node_pool.min_count
    vm_size               = var.default_node_pool.vm_size
    os_disk_size_gb       = var.default_node_pool.os_disk_size_gb
    vnet_subnet_id        = var.vnet_subnet_id
    max_pods              = var.default_node_pool.max_pods
    type                  = var.default_node_pool.agent_pool_type
    enable_node_public_ip = var.default_node_pool.enable_node_public_ip
    enable_auto_scaling   = var.default_node_pool.enable_auto_scaling

    tags = {
        Environment = "Production"
        NodePool    = "SystemLinuxNodePool"
    }
  }

  linux_profile {
    admin_username = "your_username"
    ssh_key {
        key_data = file(var.ssh_public_key)
    }
  }

  windows_profile {
    admin_username = "your_username"
    admin_password = "your_password"
  }

  # identity {
  #   type = "SystemAssigned"
  # }
    
  service_principal {
    client_id     = var.server_app_id
    client_secret = var.server_app_secret
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = "calico"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
  }
  
  # See https://docs.microsoft.com/en-us/azure/aks/azure-ad-integration
  role_based_access_control {
      azure_active_directory {
          client_app_id = var.client_app_id
          server_app_id =  var.server_app_id
          server_app_secret = var.server_app_secret
          tenant_id = var.tenant_id
      }
      enabled = true
  }

  tags = {
        Environment = "Production"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_pools" {
  # lifecycle {
  #   ignore_changes = [
  #     node_count
  #   ]
  # }

  # for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_cluster.id
  name                  = var.win_node_pool.name
  node_count            = var.win_node_pool.node_count
  vm_size               = var.win_node_pool.vm_size
  max_pods              = var.win_node_pool.max_pods
  os_disk_size_gb       = var.win_node_pool.os_disk_size_gb
  os_type               = var.win_node_pool.node_os
  vnet_subnet_id        = var.vnet_subnet_id
  enable_auto_scaling   = var.win_node_pool.enable_auto_scaling
  min_count             = var.win_node_pool.min_count
  max_count             = var.win_node_pool.max_count
  enable_node_public_ip = var.win_node_pool.enable_node_public_ip
}

resource "azurerm_monitor_diagnostic_setting" "aks_cluster_minitor" {
  name                       = "${azurerm_kubernetes_cluster.k8s_cluster.name}-audit"
  target_resource_id         = azurerm_kubernetes_cluster.k8s_cluster.id
  log_analytics_workspace_id = var.diagnostics_workspace_id

  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-controller-manager"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "cluster-autoscaler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-scheduler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-audit"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }
}
