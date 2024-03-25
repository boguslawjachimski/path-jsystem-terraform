# Resources group (project)
resource "azurerm_resource_group" "sft" {
  name     = "${local.name}-resources-group"
  location = var.region
}

# NETWORK & SUBNETS
resource "azurerm_virtual_network" "sft_net" {
  name                = "${local.name}-network"
  address_space       = ["10.113.0.0/16"]
  location            = var.region
  resource_group_name = azurerm_resource_group.sft.name 
  subnet {
    name           = "${local.name}-public-subnet"
    address_prefix = "10.113.0.0/24"
    security_group = azurerm_network_security_group.public_nsg.id
  }
} 
