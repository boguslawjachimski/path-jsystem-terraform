# NIC
resource "azurerm_network_interface" "stf_nic_vm" {
    name                = "${local.name}-nic-vm"
    location            = azurerm_resource_group.sft.location
    resource_group_name = azurerm_resource_group.sft.name

    ip_configuration {
        name                          = "public"
        subnet_id                     = element([for subnet in azurerm_virtual_network.sft_net.subnet : 
        subnet.id 
        if subnet.name == "${local.name}-public-subnet"], 0)
        public_ip_address_id          = azurerm_public_ip.stf_public_ip.id
        private_ip_address_allocation = "Dynamic"   
    }
}

# Public IP
resource "azurerm_public_ip" "stf_public_ip" {
    name                = "${local.name}-public-ip"
    location            = azurerm_resource_group.sft.location
    resource_group_name = azurerm_resource_group.sft.name
    allocation_method   = "Static"
}