output "vnic" {
  value = azurerm_network_interface.vnic
  description = "A collection of network interface objects"
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "virtual_network_subnet" {
  value = azurerm_virtual_network.vnet.subnet
  description = "All the subnets accociated with this network"
}
