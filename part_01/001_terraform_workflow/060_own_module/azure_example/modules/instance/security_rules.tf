######################################
#     Public NetworkSecurityGroup
######################################
resource "azurerm_network_security_rule" "public-allow-all-outbound" {
  name                        = "public-allow-all-outbound"
  description                 = "Allow Traffic to outside the public network"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sft.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

resource "azurerm_network_security_rule" "public-allow-all-http-inbound" {
  name                        = "public-allow-all-http-inbound"
  description                 = "Allow inbound traffic from internet"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sft.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

resource "azurerm_network_security_rule" "public-allow-all-https-inbound" {
  name                        = "public-allow-all-https-inbound"
  description                 = "Allow inbound traffic from internet"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sft.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

######################################
#     Private NetworkSecurityGroup
######################################

resource "azurerm_network_security_rule" "private-allow-inbound-my-home" {
  name                        = "private-allow-inbound-my-home"
  description                 = "Allow inbound traffic from My Home IP"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "31.179.133.30/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sft.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}