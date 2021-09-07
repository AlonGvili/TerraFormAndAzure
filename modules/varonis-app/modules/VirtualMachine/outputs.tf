output "availability_set_id" {
  value = azurerm_availability_set.avset.id
}

output "network_interface_ids" {
  value = azurerm_linux_virtual_machine.linux_vm[0].network_interface_ids
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.linux_vm[0].private_ip_address
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.linux_vm[0].public_ip_address
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.linux_vm[0].admin_username
}

output "admin_password" {
  value = azurerm_linux_virtual_machine.linux_vm[0].admin_password
  sensitive = true
}