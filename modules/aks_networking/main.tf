# Security
resource "azurerm_network_security_group" "nsg" {
  name                = "aks-subnet-nsg"
  location            = var.location
  resource_group_name = var.node_resource_group_name
}

# Link the subnet with the network securiy group
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
