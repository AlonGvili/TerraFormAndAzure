resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-${var.location}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  domain_name_label   = "${var.prefix}-${var.location}"
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_lb" "load_balancer" {
  name                = "${var.prefix}-${var.location}-load-balncer"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

}

resource "azurerm_lb_backend_address_pool" "load_balancer_backend_address_pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "${azurerm_lb.load_balancer.name}-backend-pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_address_pool_association" {
  count                   = length(var.vnic)
  backend_address_pool_id = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
  ip_configuration_name   = "internal"
  network_interface_id    = element(var.vnic.*.id, count.index)
}

resource "azurerm_lb_probe" "load_balancer_probe" {
  name                = "tcp-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.load_balancer.id
  protocol            = "tcp"
  port                = 80
}

resource "azurerm_lb_rule" "load_balancer_rule" {
  name                           = "http"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.load_balancer.id
  probe_id                       = azurerm_lb_probe.load_balancer_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
  frontend_ip_configuration_name = azurerm_public_ip.public_ip.name
  protocol                       = "Tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
}
