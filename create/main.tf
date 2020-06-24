/*
  To RUN, cd to prod folder, then:
    terraform init
    terraform plan -out out.plan
    terraform apply out.plan
  To DESTROY, run:
    terraform destroy
*/

/* ======== PART 1 - CLUSTER CREATION ==============*/

# Create the Resource Group for AKS cluster resources
resource "azurerm_resource_group" "aks_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# AKS Cluster Network
module "aks_networking" {
  source                          = "../modules/aks_networking"
  subnet_id                       = var.vnet_subnet_id
  node_resource_group_name        = azurerm_resource_group.aks_resource_group.name
  location                        = var.location
}

# AKS Log Analytics
module "aks_azure_monitoring" {
  source                           = "../modules/aks_azure_monitoring"
  log_analytics_workspace_resource_group     = azurerm_resource_group.aks_resource_group.name
}

# AKS Cluster creation
module "aks_cluster" {
  source                   = "../modules/aks_cluster"
  cluster_name             = var.cluster_name
  location                 = var.location
  dns_prefix               = var.dns_prefix
  resource_group_name      = azurerm_resource_group.aks_resource_group.name
  kubernetes_version       = var.kubernetes_version
  vnet_subnet_id           = var.vnet_subnet_id
  client_app_id            = var.client_app_id
  server_app_secret        = var.server_app_secret
  server_app_id            = var.server_app_id
  tenant_id                = var.tenant_id
  diagnostics_workspace_id = module.aks_azure_monitoring.azurerm_log_analytics_workspace
}
