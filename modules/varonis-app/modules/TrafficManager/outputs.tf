output "fqdn" {
  value = azurerm_traffic_manager_profile.tmp.fqdn
  description = "The fqdn of this traffic manager, you can use this fqdn to access the public url"
}