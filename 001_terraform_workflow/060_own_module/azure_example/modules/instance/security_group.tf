resource "azurerm_network_security_group" "public_nsg" {
  name = "${local.name}-public-nsg"
  location = azurerm_resource_group.sft.location
  resource_group_name = azurerm_resource_group.sft.name
  tags = {
    environment = "staging"
  }
}