# Use Azure storage account for terraform state
terraform {
    required_version = ">= 0.12"
    backend "azurerm" {
      resource_group_name  = "Your_rosource_group"
      storage_account_name = "k8saccount"
      container_name       = "tfaksconfig"
      access_key = ".....="
    }
}

# Use current login AD user via Azure CLI, eg. az login
provider "azurerm" {
  version = "~> 2.4"
  subscription_id = "4....a71"
  tenant_id       = "885....b3"
  features {}
}

provider "kubernetes" {
    // Terraform will load from your local kube.config file
}
