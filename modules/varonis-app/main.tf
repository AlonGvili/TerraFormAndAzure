resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

module "network" {
  source                = "./modules/network"
  resource_group_name   = var.resource_group_name
  location              = var.location
  prefix                = var.prefix
  virtual_machine_count = var.virtual_machine_count
  tags                  = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "trafficmanager" {
  source              = "./modules/trafficmanager"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  load_balancer_name  = module.loadbalancer.name
  tags                = var.tags

  depends_on = [
    module.loadbalancer,
    azurerm_resource_group.rg
  ]
}

module "virtualmachine" {
  source                = "./modules/virtualmachine"
  resource_group_name   = var.resource_group_name
  location              = var.location
  prefix                = var.prefix
  virtual_machine_count = var.virtual_machine_count
  tags                  = var.tags
  vnic = module.network.vnic

  depends_on = [
    azurerm_resource_group.rg,
    module.network
  ]
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  tags                = var.tags
  vnic                = module.network.vnic

  depends_on = [
    azurerm_resource_group.rg
  ]
}


/*

output "private_ip_address" {
  value = module.loadbalancer.private_ip_address
}

output "fqdn" {
  value = module.loadbalancer.fqdn
}

output "id" {
  value = module.loadbalancer.id
}

output "name" {
  value = module.loadbalancer.name
}

output "backend_address_pool_id" {
  value = module.loadbalancer.backend_address_pool_id
}


*/