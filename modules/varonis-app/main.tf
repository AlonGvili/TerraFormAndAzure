resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

module "application_network" {
  source                = "./modules/network"
  resource_group_name   = var.resource_group_name
  location              = var.location
  prefix                = var.prefix
  virtual_machine_count = var.virtual_machine_count
  tags                  = var.tags
}

module "application_trafficmanager" {
  source              = "./modules/trafficmanager"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  load_balancer_name  = module.application_loadbalancer.name
  tags                = var.tags

  depends_on = [
    module.application_loadbalancer,
  ]
}

module "application_virtualmachine" {
  source                = "./modules/virtualmachine"
  resource_group_name   = var.resource_group_name
  location              = var.location
  prefix                = var.prefix
  virtual_machine_count = var.virtual_machine_count
  tags                  = var.tags
  vnic                  = module.application_network.vnic

  depends_on = [
    module.application_network
  ]
}

module "application_loadbalancer" {
  source              = "./modules/loadbalancer"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  tags                = var.tags
  vnic                = module.application_network.vnic
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