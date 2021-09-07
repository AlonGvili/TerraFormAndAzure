data "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_traffic_manager_profile" "tmp" {
  name                   = "${var.prefix}-tm-profile"
  resource_group_name    = var.resource_group_name
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = var.resource_group_name
    ttl           = 30
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "endpoint" {
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.tmp.name
  target_resource_id  = data.azurerm_lb.lb.frontend_ip_configuration[0].public_ip_address_id
  type                = "azureEndpoints"
  weight              = 100

  depends_on = [
    data.azurerm_lb.lb
  ]
}
