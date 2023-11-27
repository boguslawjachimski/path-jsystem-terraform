# Resources group (project)
resource "azurerm_resource_group" "sft" {
  name     = "stf-resources-group"
  location = "West Europe"
}

# NETWORK
resource "azurerm_virtual_network" "sft_net" {
  name                = "sft-network"
  address_space       = ["10.113.0.0/16"]
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.sft.name # reference to resource group
  # Spróbuj dodac po nazwie nie odnosząc sie do innego obiektu i zobacz wtedy plik graph.png
}

# SUBNET
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.sft.name # reference to resource group
  virtual_network_name = azurerm_virtual_network.sft_net.name # reference to virtual network
  address_prefixes     = ["10.113.0.0/24"]
  # Spróbuj dodac po nazwie nie odnosząc sie do innego obiektu i zobacz wtedy plik graph.png
}