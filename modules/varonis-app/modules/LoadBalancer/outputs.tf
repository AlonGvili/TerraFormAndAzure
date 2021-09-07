output "private_ip_address" {
  value = azurerm_lb.load_balancer.private_ip_address
}

output "fqdn" {
  value = azurerm_public_ip.public_ip.fqdn
}

output "id" {
  value = azurerm_lb.load_balancer.id
}

output "name" {
  value = azurerm_lb.load_balancer.name
}

output "backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
}