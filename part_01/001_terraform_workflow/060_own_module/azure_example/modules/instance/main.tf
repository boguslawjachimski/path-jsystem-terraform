

# VM
resource "azurerm_virtual_machine" "main" {
  name                  = "${local.name}-vm"
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
    name              = "${local.name}-os-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${local.name}-vm"
    admin_username = "ubuntu"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = var.sshkey
    }
  }
  tags = {
    environment = "staging"
  }
}