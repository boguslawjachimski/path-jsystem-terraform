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
resource "azurerm_subnet" "stf_internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.sft.name # reference to resource group
  virtual_network_name = azurerm_virtual_network.sft_net.name # reference to virtual network
  address_prefixes     = ["10.113.0.0/24"]
  # Spróbuj dodac po nazwie nie odnosząc sie do innego obiektu i zobacz wtedy plik graph.png
}


# NIC
resource "azurerm_network_interface" "stf_nic_vm" {
    name                = "stf-nic-vm"
    location            = azurerm_resource_group.sft.location
    resource_group_name = azurerm_resource_group.sft.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.stf_internal.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.stf_public_ip.id
    }
}

# Public IP
resource "azurerm_public_ip" "stf_public_ip" {
    name                = "stf-public-ip"
    location            = azurerm_resource_group.sft.location
    resource_group_name = azurerm_resource_group.sft.name
    allocation_method   = "Static"
}

# VM
resource "azurerm_virtual_machine" "main" {
  name                  = "stf-test-vm"
  location              = azurerm_resource_group.sft.location
  resource_group_name   = azurerm_resource_group.sft.name
  network_interface_ids = [azurerm_network_interface.stf_nic_vm.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "stf-os-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "stf-example-vm"
    admin_username = "ubuntu"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = tls_private_key.stf_ssh_key.public_key_openssh
    }
  }
  tags = {
    environment = "staging"
  }
}