resource "random_integer" "vmid" {
  min = 123456
  max = 654321
}

resource "azurerm_availability_set" "avset" {
  name                         = "${var.prefix}-${var.location}-avset-${random_integer.vmid.result}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                 = var.virtual_machine_count
  name                  = "${var.prefix}-${var.location}-lvm-${random_integer.vmid.result}-${count.index}"
  location              = var.location
  availability_set_id   = azurerm_availability_set.avset.id
  resource_group_name   = var.resource_group_name
  network_interface_ids = [element(var.vnic.*.id, count.index)]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "${var.prefix}-${var.location}-lvm-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "${var.prefix}-${var.location}-lvm-${random_integer.vmid.result}"
  admin_username                  = "varonisadmin"
  admin_password                  = "P@ssword1"
  disable_password_authentication = false

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "linux-vm-ext" {
  count                      = length(azurerm_linux_virtual_machine.linux_vm)
  name                       = "CustomScript"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm[count.index].id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "commandToExecute": "sudo bash -c 'apt-get update && apt-get -y install apache2' "
    }
SETTINGS
}
